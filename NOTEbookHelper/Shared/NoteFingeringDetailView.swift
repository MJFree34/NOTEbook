//
//  NoteFingeringDetailView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 12/29/22.
//

import SwiftUI

struct NoteFingeringDetailView: View {
    @Environment(\.editMode) private var editMode
    
    @EnvironmentObject private var helperChartsController: HelperChartsController
    
    @Binding var noteFingering: NoteFingering
    
    let categoryName: String
    let instrumentType: InstrumentType
    
    @State private var showEditSheet = false
    @State private var updateIndex: Int?
    @State private var updateFingering: Fingering?
    
    init(noteFingering: NoteFingering, categoryName: String, instrumentType: InstrumentType) {
        self._noteFingering = HelperChartsController.shared.bindingToNoteFingering(in: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0]) ?? .constant(noteFingering)
        self.categoryName = categoryName
        self.instrumentType = instrumentType
    }
    
    var body: some View {
        VStack(alignment: .center) {
            NoteCell(noteFingering: noteFingering)
                .fixedSize()
            
            List {
                if (noteFingering.fingerings.isEmpty) {
                    Text("No fingering exists")
                } else {
                    ForEach(noteFingering.fingerings, id: \.self) { fingering in
                        fingeringView(fingering: fingering)
                            .onTapGesture {
                                if editMode?.wrappedValue.isEditing == true {
                                    self._updateIndex.wrappedValue = self._noteFingering.wrappedValue.fingerings.firstIndex { $0 == fingering }
                                    self._updateFingering.wrappedValue = fingering
                                    showEditSheet = true
                                }
                            }
                    }
                    .onMove(perform: moveFingering)
                    .onDelete(perform: deleteFingering)
                }
            }
            .listStyle(.inset)
        }
        .sheet(isPresented: $showEditSheet) {
            if let updateIndex = $updateIndex.wrappedValue, let updateFingering = $updateFingering.wrappedValue {
                switch instrumentType {
                case .trumpet:
                    AddThreeFingeringView(categoryName: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0], fingeringIndex: updateIndex, fingering: updateFingering)
                default:
                    Text("Update Fingering")
                }
            } else {
                switch instrumentType {
                case .trumpet:
                    AddThreeFingeringView(categoryName: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0])
                default:
                    Text("Add Fingering")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if editMode?.wrappedValue.isEditing == true {
                        editMode?.wrappedValue = EditMode.inactive
                    } else {
                        editMode?.wrappedValue = EditMode.active
                    }
                } label: {
                    if editMode?.wrappedValue.isEditing == true {
                        Text("Done")
                    } else {
                        Image(systemName: "pencil")
                    }
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                if editMode?.wrappedValue.isEditing == true {
                    Button {
                        showEditSheet = true
                    } label: {
                        Text("Add Fingering")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
    
    @ViewBuilder
    private func fingeringView(fingering: Fingering) -> some View {
        switch instrumentType {
        case .trumpet:
            ThreeValveFingeringView(fingering: fingering)
        default:
            Text("Fingering")
        }
    }
    
    private func moveFingering(fromOffsets: IndexSet, toOffset: Int) {
        helperChartsController.moveNoteFingeringInFingeringChart(categoryName: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0], fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    private func deleteFingering(atOffsets offsets: IndexSet) {
        helperChartsController.deleteFingeringInFingeringChart(categoryName: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0], atOffsets: offsets)
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[1], categoryName: HelperChartsController.exampleChartCategory.name, instrumentType: HelperChartsController.exampleChart.instrument.type)
            }
            
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[0], categoryName: HelperChartsController.exampleChartCategory.name, instrumentType: HelperChartsController.exampleChart.instrument.type)
            }
            
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[2], categoryName: HelperChartsController.exampleChartCategory.name, instrumentType: HelperChartsController.exampleChart.instrument.type)
            }
        }
        .environmentObject(HelperChartsController.shared)
    }
}

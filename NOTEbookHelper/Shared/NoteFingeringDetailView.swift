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
    
    @State private var noteFingering: NoteFingering
    
    let categoryName: String
    let instrumentType: InstrumentType
    
    @State private var updateIndex: Int?
    @State private var addFingering: Fingering?
    @State private var savedFingering = Fingering()
    
    init(noteFingering: NoteFingering, categoryName: String, instrumentType: InstrumentType) {
        self._noteFingering = State(wrappedValue: noteFingering)
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
                        HStack {
                            fingeringView(fingering: fingering)
                            
                            Rectangle()
                                .fill(.white)
                        }
                        .onTapGesture {
                            if editMode?.wrappedValue.isEditing == true {
                                updateIndex = noteFingering.fingerings.firstIndex { $0 == fingering }
                                addFingering = fingering
                            }
                        }
                    }
                    .onMove(perform: moveFingering)
                    .onDelete(perform: deleteFingering)
                }
            }
            .listStyle(.inset)
        }
        .sheet(item: $addFingering, onDismiss: {
            guard savedFingering != Fingering() else { return }
            
            if let updateIndex = updateIndex {
                noteFingering = helperChartsController.updateFingering(in: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0], fingeringIndex: updateIndex, fingering: savedFingering) ?? noteFingering
                self.updateIndex = nil
            } else {
                noteFingering = helperChartsController.addFingering(in: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0], fingering: savedFingering) ?? noteFingering
            }
            
            savedFingering = Fingering()
        }, content: { fingering in
            let isAdd = fingering == Fingering()
            
            switch instrumentType {
            case .trumpet:
                AddThreeFingeringView(categoryName: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0], isAdd: isAdd, fingering: $savedFingering, key1: fingering.keys?[0] ?? false, key2: fingering.keys?[1] ?? false, key3: fingering.keys?[2] ?? false)
                    .interactiveDismissDisabled()
            default:
                Text("\(isAdd ? "Add" : "Update") Fingering")
            }
        })
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
                        addFingering = Fingering()
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
        noteFingering = helperChartsController.moveNoteFingeringInFingeringChart(categoryName: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0], fromOffsets: fromOffsets, toOffset: toOffset) ?? noteFingering
    }
    
    private func deleteFingering(atOffsets offsets: IndexSet) {
        noteFingering = helperChartsController.deleteNoteFingeringInFingeringChart(categoryName: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0], atOffsets: offsets) ?? noteFingering
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

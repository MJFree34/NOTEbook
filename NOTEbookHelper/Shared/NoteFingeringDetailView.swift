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
    
    let instrumentType: InstrumentType
    let categoryName: String
    
    @State private var showEditSheet = false
    
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
                    }
                    .onMove(perform: moveFingering)
                    .onDelete(perform: deleteFingering)
                }
            }
            .listStyle(.inset)
        }
        .sheet(isPresented: $showEditSheet) {
            switch instrumentType {
            case .trumpet:
                AddThreeFingeringView(categoryName: categoryName, instrumentType: instrumentType, firstNote: noteFingering.notes[0])
            default:
                Text("Add Fingering")
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
                NoteFingeringDetailView(noteFingering: HelperChartsController.shared.bindingToNoteFingering(in: HelperChartsController.exampleChartCategory.name, instrumentType: HelperChartsController.exampleChart.instrument.type, firstNote: HelperChartsController.exampleChart.noteFingerings[1].notes[0]) ?? .constant(HelperChartsController.exampleChart.noteFingerings[1]), instrumentType: HelperChartsController.exampleChart.instrument.type, categoryName: HelperChartsController.exampleChartCategory.name)
            }
            
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.shared.bindingToNoteFingering(in: HelperChartsController.exampleChartCategory.name, instrumentType: HelperChartsController.exampleChart.instrument.type, firstNote: HelperChartsController.exampleChart.noteFingerings[0].notes[0]) ?? .constant(HelperChartsController.exampleChart.noteFingerings[0]), instrumentType: HelperChartsController.exampleChart.instrument.type, categoryName: HelperChartsController.exampleChartCategory.name)
            }
            
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.shared.bindingToNoteFingering(in: HelperChartsController.exampleChartCategory.name, instrumentType: HelperChartsController.exampleChart.instrument.type, firstNote: HelperChartsController.exampleChart.noteFingerings[2].notes[0]) ?? .constant(HelperChartsController.exampleChart.noteFingerings[2]), instrumentType: HelperChartsController.exampleChart.instrument.type, categoryName: HelperChartsController.exampleChartCategory.name)
            }
        }
        .environmentObject(HelperChartsController.shared)
    }
}

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
            addFingeringView(fingering: fingering, isAdd: fingering == Fingering())
                .interactiveDismissDisabled()
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
        case .flute:
            FluteFingeringView(fingering: fingering)
        case .clarinet:
            Text("Clarinet")
        case .altoSaxophone, .tenorSaxophone:
            Text("Alto/Tenor Saxophone")
        case .baritoneSaxophone:
            Text("Baritone Saxophone")
        case .trumpet, .mellophone, .fFrenchHorn, .baritoneTC, .baritoneBC, .threeValveBBbTuba, .threeValveEbTuba:
            ThreeValveFingeringView(fingering: fingering)
        case .euphoniumTCNC, .euphoniumTCC, .euphoniumBCNC, .euphoniumBCC:
            FourValveFingeringView(fingering: fingering)
        case .fBbFrenchHorn:
            BbTriggerThreeValveFingeringView(fingering: fingering)
        case .tenorTrombone:
            PositionFingeringView(fingering: fingering)
        case .fTriggerTenorTrombone:
            FTriggerPositionFingeringView(fingering: fingering)
        }
    }
    
    @ViewBuilder
    private func addFingeringView(fingering: Fingering, isAdd: Bool) -> some View {
        switch instrumentType {
        case .flute:
            AddFluteFingeringView(isAdd: isAdd, fingering: $savedFingering, key1: fingering.keys?[0] ?? false, key2: fingering.keys?[1] ?? false, key3: fingering.keys?[2] ?? false, key4: fingering.keys?[3] ?? false, key5: fingering.keys?[4] ?? false, key6: fingering.keys?[5] ?? false, key7: fingering.keys?[6] ?? false, lever1: fingering.keys?[7] ?? false, lever2: fingering.keys?[8] ?? false, trill1: fingering.keys?[9] ?? false, trill2: fingering.keys?[10] ?? false, foot1: fingering.keys?[11] ?? false, foot2: fingering.keys?[12] ?? false, foot3: fingering.keys?[13] ?? false, thumb1: fingering.keys?[14] ?? false, thumb2: fingering.keys?[15] ?? false)
        case .clarinet:
            Text("Clarinet")
        case .altoSaxophone, .tenorSaxophone:
            Text("Alto/Tenor Saxophone")
        case .baritoneSaxophone:
            Text("Baritone Saxophone")
        case .trumpet, .mellophone, .fFrenchHorn, .baritoneTC, .baritoneBC, .threeValveBBbTuba, .threeValveEbTuba:
            AddThreeValveFingeringView(isAdd: isAdd, fingering: $savedFingering, key1: fingering.keys?[0] ?? false, key2: fingering.keys?[1] ?? false, key3: fingering.keys?[2] ?? false)
        case .euphoniumTCNC, .euphoniumTCC, .euphoniumBCNC, .euphoniumBCC:
            AddFourValveFingeringView(isAdd: isAdd, fingering: $savedFingering, key1: fingering.keys?[0] ?? false, key2: fingering.keys?[1] ?? false, key3: fingering.keys?[2] ?? false, key4: fingering.keys?[3] ?? false)
        case .fBbFrenchHorn:
            AddBbTriggerThreeValveFingeringView(isAdd: isAdd, fingering: $savedFingering, trigger: fingering.triggers?[0] ?? false, key1: fingering.keys?[0] ?? false, key2: fingering.keys?[1] ?? false, key3: fingering.keys?[2] ?? false)
        case .tenorTrombone:
            AddPositionFingeringView(isAdd: isAdd, fingering: $savedFingering, value: fingering.position?.value ?? .none, type: fingering.position?.type ?? .natural)
        case .fTriggerTenorTrombone:
            AddFTriggerPositionFingeringView(isAdd: isAdd, fingering: $savedFingering, trigger: fingering.triggers?[0] ?? false, value: fingering.position?.value ?? .none, type: fingering.position?.type ?? .natural)
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

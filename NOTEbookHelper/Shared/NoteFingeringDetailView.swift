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
    
    let color: Color
    let categoryName: String
    let instrumentType: InstrumentType
    
    @State private var updateIndex: Int?
    @State private var addFingering: Fingering?
    @State private var savedFingering = Fingering()
    
    init(noteFingering: NoteFingering, color: Color, categoryName: String, instrumentType: InstrumentType) {
        self._noteFingering = State(wrappedValue: noteFingering)
        self.color = color
        self.categoryName = categoryName
        self.instrumentType = instrumentType
    }
    
    var body: some View {
        VStack(alignment: .center) {
            NoteCell(noteFingering: noteFingering, color: color)
                .fixedSize()

            List {
                Group {
                    if (noteFingering.fingerings.isEmpty) {
                        Text("No fingering exists")
                    } else {
                        ForEach(noteFingering.fingerings, id: \.self) { fingering in
                            HStack {
                                fingeringView(fingering: fingering)
                                
                                Rectangle()
                                    .fill(Color("LightestestAqua"))
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
                .listRowBackground(Color.clear)
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
        .scrollContentBackground(.hidden)
        .background(Color("LightestestAqua"))
    }
    
    @ViewBuilder
    private func fingeringView(fingering: Fingering) -> some View {
        switch instrumentType {
        case .flute:
            FluteFingeringView(fingering: fingering)
        case .clarinet:
            ClarinetFingeringView(fingering: fingering)
        case .altoSaxophone, .tenorSaxophone:
            SaxophoneFingeringView(fingering: fingering)
        case .baritoneSaxophone:
            BaritoneSaxophoneFingeringView(fingering: fingering)
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
            AddClarinetFingeringView(isAdd: isAdd, fingering: $savedFingering, key1: fingering.keys?[0] ?? false, key2: fingering.keys?[1] ?? false, key3: fingering.keys?[2] ?? false, key4: fingering.keys?[3] ?? false, key5: fingering.keys?[4] ?? false, key6: fingering.keys?[5] ?? false, bottom1: fingering.keys?[6] ?? false, bottom2: fingering.keys?[7] ?? false, bottom3: fingering.keys?[8] ?? false, bottom4: fingering.keys?[9] ?? false, lever1: fingering.keys?[10] ?? false, lever2: fingering.keys?[11] ?? false, lever3: fingering.keys?[12] ?? false, lever4: fingering.keys?[13] ?? false, lever5: fingering.keys?[14] ?? false, trigger1: fingering.keys?[15] ?? false, trigger2: fingering.keys?[16] ?? false, trigger3: fingering.keys?[17] ?? false, side1: fingering.keys?[18] ?? false, side2: fingering.keys?[19] ?? false, side3: fingering.keys?[20] ?? false, side4: fingering.keys?[21] ?? false, thumb1: fingering.keys?[22] ?? false, thumb2: fingering.keys?[23] ?? false)
        case .altoSaxophone, .tenorSaxophone:
            AddSaxophoneFingeringView(isAdd: isAdd, fingering: $savedFingering, key1: fingering.keys?[0] ?? false, key2: fingering.keys?[1] ?? false, key3: fingering.keys?[2] ?? false, key4: fingering.keys?[3] ?? false, key5: fingering.keys?[4] ?? false, key6: fingering.keys?[5] ?? false, bottom1: fingering.keys?[6] ?? false, bottom2: fingering.keys?[7] ?? false, chromaticFSharp: fingering.keys?[8] ?? false, side1: fingering.keys?[9] ?? false, side2: fingering.keys?[10] ?? false, side3: fingering.keys?[11] ?? false, highFSharp: fingering.keys?[12] ?? false, fork: fingering.keys?[13] ?? false, top1: fingering.keys?[14] ?? false, top2: fingering.keys?[15] ?? false, top3: fingering.keys?[16] ?? false, low1: fingering.keys?[17] ?? false, low2: fingering.keys?[18] ?? false, low3: fingering.keys?[19] ?? false, low4: fingering.keys?[20] ?? false, bis: fingering.keys?[21] ?? false, octave: fingering.keys?[22] ?? false)
        case .baritoneSaxophone:
            AddBaritoneSaxophoneFingeringView(isAdd: isAdd, fingering: $savedFingering, key1: fingering.keys?[0] ?? false, key2: fingering.keys?[1] ?? false, key3: fingering.keys?[2] ?? false, key4: fingering.keys?[3] ?? false, key5: fingering.keys?[4] ?? false, key6: fingering.keys?[5] ?? false, bottom1: fingering.keys?[6] ?? false, bottom2: fingering.keys?[7] ?? false, chromaticFSharp: fingering.keys?[8] ?? false, side1: fingering.keys?[9] ?? false, side2: fingering.keys?[10] ?? false, side3: fingering.keys?[11] ?? false, highFSharp: fingering.keys?[12] ?? false, fork: fingering.keys?[13] ?? false, top1: fingering.keys?[14] ?? false, top2: fingering.keys?[15] ?? false, top3: fingering.keys?[16] ?? false, low1: fingering.keys?[17] ?? false, low2: fingering.keys?[18] ?? false, low3: fingering.keys?[19] ?? false, low4: fingering.keys?[20] ?? false, bis: fingering.keys?[21] ?? false, octave: fingering.keys?[22] ?? false, lowA: fingering.keys?[23] ?? false)
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
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[1], color: Color("Black").opacity(0.5), categoryName: HelperChartsController.exampleChartCategory.name, instrumentType: HelperChartsController.exampleChart.instrument.type)
            }
            
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[0], color: Color("MediumRed"), categoryName: HelperChartsController.exampleChartCategory.name, instrumentType: HelperChartsController.exampleChart.instrument.type)
            }
            
            NavigationStack {
                NoteFingeringDetailView(noteFingering: HelperChartsController.exampleChart.noteFingerings[2], color: Color("Black"), categoryName: HelperChartsController.exampleChartCategory.name, instrumentType: HelperChartsController.exampleChart.instrument.type)
            }
        }
        .environmentObject(HelperChartsController.shared)
    }
}

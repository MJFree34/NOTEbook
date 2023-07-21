//
//  AddFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/17/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import ChartUI
import CommonUI
import SwiftUI

// swiftlint:disable line_length
struct AddFingeringView: View {
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var helperChartsController: HelperChartsController

//    @Binding private var fingering: any Fingering
//    private var instrumentType: Instrument.InstrumentType
//
//    private var editingFingering: any Fingering
//
//    @Binding private var keysFingering: KeysFingering
//    @Binding private var keysTriggersFingering: KeysTriggersFingering
//    @Binding private var positionFingering: PositionFingering
//    @Binding private var positionTriggersFingering: PositionTriggersFingering
//
//    init(fingering: Binding<any Fingering>, for instrumentType: Instrument.InstrumentType) {
//        self._fingering = fingering
//        self.instrumentType = instrumentType
//        self.editingFingering = fingering.wrappedValue
//
//        if let editingFingering = editingFingering as? KeysFingering {
//            _keysFingering = Binding {
//                editingFingering
//            } set: { newValue in
//                self.editingFingering = newValue
//            }
//        } else if let editingFingering = editingFingering as? KeysTriggersFingering {
//            _keysTriggersFingering = Binding {
//                editingFingering
//            } set: { newValue in
//                self.editingFingering = newValue
//            }
//        } else if let editingFingering = editingFingering as? PositionFingering {
//            _positionFingering = Binding {
//                editingFingering
//            } set: { newValue in
//                self.editingFingering = newValue
//            }
//        } else if let editingFingering = editingFingering as? PositionTriggersFingering {
//            _positionTriggersFingering = Binding {
//                editingFingering
//            } set: { newValue in
//                self.editingFingering = newValue
//            }
//        }
//    }

    @Binding private var keysFingering: KeysFingering
    private var instrumentType: Instrument.InstrumentType

    @State private var editingKeysFingering: KeysFingering

    init(fingering: Binding<KeysFingering>, for instrumentType: Instrument.InstrumentType) {
        _keysFingering = fingering
        self.instrumentType = instrumentType
        _editingKeysFingering = State(initialValue: fingering.wrappedValue)
    }

    var body: some View {
        NavigationStack {
            Group {
                switch instrumentType {
                case .cFlute:
                    FluteFingeringView(fingering: $keysFingering, isInteractive: true)
                case .bbSopranoClarinet:
                    ClarinetFingeringView(fingering: $keysFingering, isInteractive: true)
                case .ebAltoSaxophone, .bbTenorSaxophone:
                    SaxophoneFingeringView(fingering: $keysFingering, isInteractive: true)
                case .ebBaritoneSaxophone:
                    BaritoneSaxophoneFingeringView(fingering: $keysFingering, isInteractive: true)
                case .bbTrumpet, .fMellophone, .fSingleFrenchHorn, .bbBaritoneHorn, .threeValveBBbTuba, .threeValveEbTuba:
                    ThreeValveFingeringView(fingering: $keysFingering, isInteractive: true)
//                case .fBbDoubleFrenchHorn:
//                    BbTriggerThreeValveFingeringView(fingering: $keysTriggersFingering, isInteractive: true)
//                case .bbTenorTrombone:
//                    PositionFingeringView(fingering: $positionFingering, isInteractive: true)
//                case .fTriggerBbTenorTrombone:
//                    FTriggerPositionFingeringView(fingering: $positionTriggersFingering, isInteractive: true)
                case .fourValveBbEuphoniumCompensating, .fourValveBbEuphoniumNonCompensating:
                    FourValveFingeringView(fingering: $keysFingering, isInteractive: true)
                default:
                    EmptyView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                    }
                }

                ToolbarItem(placement: .bottomBar) {
                    Button {
//                        fingering.keys = [key1, key2, key3, key4, key5, key6, bottom1, bottom2, chromaticFSharp, side1, side2, side3, highFSharp, fork, top1, top2, top3, low1, low2, low3, low4, bis, octave, lowA]
                        dismiss()
                    } label: {
//                        Text("\(isAdd ? "Add" : "Update") Fingering")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LightestestAqua"))
        }
        .tint(Color("DarkAqua"))
    }

    func invalidView(fingeringType: String) -> some View {
        Text("Fingering Type: \(fingeringType) not compatible with instrument type: \(instrumentType.rawValue).")
    }
}

struct AddBaritoneSaxophoneFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PreviewBindingWrapper(wrappedBinding: KeysFingering.emptyPlaceholder) { fingeringBinding in
                AddFingeringView(fingering: fingeringBinding, for: .bbTrumpet)
            }
        }
        .environmentObject(HelperChartsController.shared)
    }
}

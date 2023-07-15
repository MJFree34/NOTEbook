//
//  AddClarinetFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/15/23.
//

import Common
import SwiftUI

struct AddClarinetFingeringView: View {
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var helperChartsController: HelperChartsController

    let isAdd: Bool

    @Binding var fingering: Fingering

    @State private var key1: Bool
    @State private var key2: Bool
    @State private var key3: Bool
    @State private var key4: Bool
    @State private var key5: Bool
    @State private var key6: Bool

    @State private var bottom1: Bool
    @State private var bottom2: Bool
    @State private var bottom3: Bool
    @State private var bottom4: Bool

    @State private var lever1: Bool
    @State private var lever2: Bool
    @State private var lever3: Bool
    @State private var lever4: Bool
    @State private var lever5: Bool

    @State private var trigger1: Bool
    @State private var trigger2: Bool
    @State private var trigger3: Bool

    @State private var side1: Bool
    @State private var side2: Bool
    @State private var side3: Bool
    @State private var side4: Bool

    @State private var thumb1: Bool
    @State private var thumb2: Bool

    init(isAdd: Bool, fingering: Binding<Fingering>, key1: Bool, key2: Bool, key3: Bool, key4: Bool, key5: Bool, key6: Bool, bottom1: Bool, bottom2: Bool, bottom3: Bool, bottom4: Bool, lever1: Bool, lever2: Bool, lever3: Bool, lever4: Bool, lever5: Bool, trigger1: Bool, trigger2: Bool, trigger3: Bool, side1: Bool, side2: Bool, side3: Bool, side4: Bool, thumb1: Bool, thumb2: Bool) {
        self.isAdd = isAdd
        self._fingering = fingering

        self._key1 = State(initialValue: key1)
        self._key2 = State(initialValue: key2)
        self._key3 = State(initialValue: key3)
        self._key4 = State(initialValue: key4)
        self._key5 = State(initialValue: key5)
        self._key6 = State(initialValue: key6)

        self._bottom1 = State(initialValue: bottom1)
        self._bottom2 = State(initialValue: bottom2)
        self._bottom3 = State(initialValue: bottom3)
        self._bottom4 = State(initialValue: bottom4)

        self._lever1 = State(initialValue: lever1)
        self._lever2 = State(initialValue: lever2)
        self._lever3 = State(initialValue: lever3)
        self._lever4 = State(initialValue: lever4)
        self._lever5 = State(initialValue: lever5)

        self._trigger1 = State(initialValue: trigger1)
        self._trigger2 = State(initialValue: trigger2)
        self._trigger3 = State(initialValue: trigger3)

        self._side1 = State(initialValue: side1)
        self._side2 = State(initialValue: side2)
        self._side3 = State(initialValue: side3)
        self._side4 = State(initialValue: side4)

        self._thumb1 = State(initialValue: thumb1)
        self._thumb2 = State(initialValue: thumb2)
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                VStack(alignment: .leading, spacing: 2) {
                    Image("ClarinetTopLeverKey\(lever4 ? "Full" : "Empty")")
                        .renderingMode(.template)
                        .padding(.leading, 16)
                        .padding(.top, 24)
                        .onTapGesture {
                            lever4.toggle()
                        }

                    HStack(spacing: 12) {
                        HStack(spacing: 2) {
                            Image("ClarinetTopLeverKey\(lever5 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    lever5.toggle()
                                }

                            Image("ClarinetCircleKey\(key1 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    key1.toggle()
                                }
                        }

                        Image("ClarinetCircleKey\(key2 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                key2.toggle()
                            }
                        Image("ClarinetCircleKey\(key3 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                key3.toggle()
                            }
                        Image("ClarinetCircleKey\(key4 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .padding(.leading, 10)
                            .onTapGesture {
                                key4.toggle()
                            }
                        Image("ClarinetCircleKey\(key5 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                key5.toggle()
                            }
                        Image("ClarinetCircleKey\(key6 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .padding(.trailing, 26)
                            .onTapGesture {
                                key6.toggle()
                            }
                    }

                    HStack(alignment: .bottom, spacing: 44) {
                        Image("ClarinetThumbKeys\(thumb1 ? "Full" : "Empty")\(thumb2 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .padding(.leading, 14)
                            .onTapGesture {
                                if !thumb1 && !thumb2 || !thumb1 && thumb2 {
                                    thumb1.toggle()
                                } else {
                                    thumb1.toggle()
                                    thumb2.toggle()
                                }
                            }

                        HStack(alignment: .bottom, spacing: 0) {
                            Image("ClarinetSmallSideKey\(side4 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    side4.toggle()
                                }
                            Image("ClarinetSmallSideKey\(side3 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    side3.toggle()
                                }
                            Image("ClarinetLargeSideKey\(side2 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    side2.toggle()
                                }
                            Image("ClarinetLargeSideKey\(side1 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    side1.toggle()
                                }
                        }
                    }
                }

                HStack(alignment: .top, spacing: 32) {
                    Image("ClarinetThinRightLeverKey\(lever3 ? "Full" : "Empty")")
                        .renderingMode(.template)
                        .onTapGesture {
                            lever3.toggle()
                        }

                    Image("ClarinetMiddleLeverKey\(lever2 ? "Full" : "Empty")")
                        .renderingMode(.template)
                        .onTapGesture {
                            lever2.toggle()
                        }
                }
                .padding(.top, 28)
                .padding(.trailing, 142)

                HStack(spacing: 33) {
                    Image("ClarinetThinLeftLeverKey\(lever1 ? "Full" : "Empty")")
                        .renderingMode(.template)
                        .onTapGesture {
                            lever1.toggle()
                        }

                    HStack(spacing: 2) {
                        Image("ClarinetBottomKeys\(bottom3 ? "Full" : "Empty")\(bottom4 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                if !bottom3 && !bottom4 || !bottom3 && bottom4 {
                                    bottom3.toggle()
                                } else {
                                    bottom3.toggle()
                                    bottom4.toggle()
                                }
                            }
                        Image("ClarinetBottomKeys\(bottom1 ? "Full" : "Empty")\(bottom2 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                if !bottom1 && !bottom2 || !bottom1 && bottom2 {
                                    bottom1.toggle()
                                } else {
                                    bottom1.toggle()
                                    bottom2.toggle()
                                }
                            }
                    }
                }
                .padding(.top, 44)

                HStack(alignment: .top, spacing: -8) {
                    Image("ClarinetTriggerKey3\(trigger3 ? "Full" : "Empty")")
                        .renderingMode(.template)
                        .padding(.top, 4)
                        .onTapGesture {
                            trigger3.toggle()
                        }

                    VStack(alignment: .trailing, spacing: 2) {
                        Image("ClarinetTriggerKey1\(trigger1 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                trigger1.toggle()
                            }
                        Image("ClarinetTriggerKey2\(trigger2 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .padding(.trailing, 6)
                            .onTapGesture {
                                trigger2.toggle()
                            }
                    }
                }
                .padding(.trailing, 56)
            }
            .foregroundColor(Color("Black"))
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
                        fingering.keys = [key1, key2, key3, key4, key5, key6, bottom1, bottom2, bottom3, bottom4, lever1, lever2, lever3, lever4, lever5, trigger1, trigger2, trigger3, side1, side2, side3, side4, thumb1, thumb2]
                        dismiss()
                    } label: {
                        Text("\(isAdd ? "Add" : "Update") Fingering")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LightestestAqua"))
        }
        .tint(Color("DarkAqua"))
    }
}

struct AddClarinetFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddClarinetFingeringView(isAdd: true, fingering: .constant(Fingering()), key1: false, key2: false, key3: false, key4: false, key5: false, key6: false, bottom1: false, bottom2: false, bottom3: false, bottom4: false, lever1: false, lever2: false, lever3: false, lever4: false, lever5: false, trigger1: false, trigger2: false, trigger3: false, side1: false, side2: false, side3: false, side4: false, thumb1: false, thumb2: false)

            AddClarinetFingeringView(isAdd: false, fingering: .constant(Fingering()), key1: true, key2: true, key3: true, key4: true, key5: true, key6: true, bottom1: true, bottom2: true, bottom3: true, bottom4: true, lever1: true, lever2: true, lever3: true, lever4: true, lever5: true, trigger1: true, trigger2: true, trigger3: true, side1: true, side2: true, side3: true, side4: true, thumb1: true, thumb2: true)
        }
        .environmentObject(HelperChartsController.shared)
    }
}

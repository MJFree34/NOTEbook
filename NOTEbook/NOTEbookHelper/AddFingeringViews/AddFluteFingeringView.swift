//
//  AddFluteFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/14/23.
//

import Common
import SwiftUI

struct AddFluteFingeringView: View {
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
    @State private var key7: Bool

    @State private var lever1: Bool
    @State private var lever2: Bool

    @State private var trill1: Bool
    @State private var trill2: Bool

    @State private var foot1: Bool
    @State private var foot2: Bool
    @State private var foot3: Bool

    @State private var thumb1: Bool
    @State private var thumb2: Bool

    init(isAdd: Bool, fingering: Binding<Fingering>, key1: Bool, key2: Bool, key3: Bool, key4: Bool, key5: Bool, key6: Bool, key7: Bool, lever1: Bool, lever2: Bool, trill1: Bool, trill2: Bool, foot1: Bool, foot2: Bool, foot3: Bool, thumb1: Bool, thumb2: Bool) {
        self.isAdd = isAdd
        self._fingering = fingering

        self._key1 = State(initialValue: key1)
        self._key2 = State(initialValue: key2)
        self._key3 = State(initialValue: key3)
        self._key4 = State(initialValue: key4)
        self._key5 = State(initialValue: key5)
        self._key6 = State(initialValue: key6)
        self._key7 = State(initialValue: key7)

        self._lever1 = State(initialValue: lever1)
        self._lever2 = State(initialValue: lever2)

        self._trill1 = State(initialValue: trill1)
        self._trill2 = State(initialValue: trill2)

        self._foot1 = State(initialValue: foot1)
        self._foot2 = State(initialValue: foot2)
        self._foot3 = State(initialValue: foot3)

        self._thumb1 = State(initialValue: thumb1)
        self._thumb2 = State(initialValue: thumb2)
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                Image("FluteLeverKeys\(lever1 ? "Full" : "Empty")\(lever2 ? "Full" : "Empty")")
                    .renderingMode(.template)
                    .padding(.trailing, 74)
                    .padding(.bottom, 6)
                    .onTapGesture {
                        if !lever1 && !lever2 || !lever1 && lever2 {
                            lever1.toggle()
                        } else {
                            lever1.toggle()
                            lever2.toggle()
                        }
                    }

                HStack(alignment: .top, spacing: 0) {
                    VStack(spacing: 2) {
                        HStack(spacing: 5) {
                            Image("FluteCircleKey\(key1 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    key1.toggle()
                                }
                            Image("FluteCircleKey\(key2 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    key2.toggle()
                                }
                            Image("FluteCircleKey\(key3 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    key3.toggle()
                                }
                        }

                        Image("FluteThumbKeys\(thumb1 ? "Full" : "Empty")\(thumb2 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                if !thumb1 && !thumb2 || !thumb1 && thumb2 {
                                    thumb1.toggle()
                                } else {
                                    thumb1.toggle()
                                    thumb2.toggle()
                                }
                            }
                    }

                    VStack(spacing: -8) {
                        HStack(spacing: 5) {
                            Image("FluteCircleKey\(key4 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    key4.toggle()
                                }
                            Image("FluteCircleKey\(key5 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    key5.toggle()
                                }
                            Image("FluteCircleKey\(key6 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    key6.toggle()
                                }
                        }

                        HStack(spacing: 23) {
                            Image("FluteTrillKey\(trill1 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    trill1.toggle()
                                }
                            Image("FluteTrillKey\(trill2 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    trill2.toggle()
                                }
                        }
                    }
                    .padding(.leading, 20)

                    Image("FlutePinkyKey\(key7 ? "Full" : "Empty")")
                        .renderingMode(.template)
                        .padding(.leading, 2)
                        .onTapGesture {
                            key7.toggle()
                        }

                    VStack(spacing: 3.5) {
                        Image("FluteFootKey2\(foot3 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                foot3.toggle()
                            }
                        Image("FluteFootKey2\(foot2 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                foot2.toggle()
                            }
                        Image("FluteFootKey1\(foot1 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                foot1.toggle()
                            }
                    }
                    .padding(.leading, 2)
                }
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
                        fingering.keys = [key1, key2, key3, key4, key5, key6, key7, lever1, lever2, trill1, trill2, foot1, foot2, foot3, thumb1, thumb2]
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

struct AddFluteFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddFluteFingeringView(isAdd: true, fingering: .constant(Fingering()), key1: false, key2: false, key3: false, key4: false, key5: false, key6: false, key7: false, lever1: false, lever2: false, trill1: false, trill2: false, foot1: false, foot2: false, foot3: false, thumb1: false, thumb2: false)

            AddFluteFingeringView(isAdd: false, fingering: .constant(Fingering()), key1: true, key2: true, key3: true, key4: true, key5: true, key6: true, key7: true, lever1: true, lever2: true, trill1: true, trill2: true, foot1: true, foot2: true, foot3: true, thumb1: true, thumb2: true)
        }
        .environmentObject(HelperChartsController.shared)
    }
}

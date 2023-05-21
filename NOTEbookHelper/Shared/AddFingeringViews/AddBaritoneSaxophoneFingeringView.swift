//
//  AddBaritoneSaxophoneFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/17/23.
//

import SwiftUI

struct AddBaritoneSaxophoneFingeringView: View {
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
    
    @State private var chromaticFSharp: Bool
    
    @State private var side1: Bool
    @State private var side2: Bool
    @State private var side3: Bool
    
    @State private var highFSharp: Bool
    
    @State private var fork: Bool
    
    @State private var top1: Bool
    @State private var top2: Bool
    @State private var top3: Bool
    
    @State private var low1: Bool
    @State private var low2: Bool
    @State private var low3: Bool
    @State private var low4: Bool
    
    @State private var bis: Bool
    
    @State private var octave: Bool
    
    @State private var lowA: Bool
    
    init(isAdd: Bool, fingering: Binding<Fingering>, key1: Bool, key2: Bool, key3: Bool, key4: Bool, key5: Bool, key6: Bool, bottom1: Bool, bottom2: Bool, chromaticFSharp: Bool, side1: Bool, side2: Bool, side3: Bool, highFSharp: Bool, fork: Bool, top1: Bool, top2: Bool, top3: Bool, low1: Bool, low2: Bool, low3: Bool, low4: Bool, bis: Bool, octave: Bool, lowA: Bool) {
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
        
        self._chromaticFSharp = State(initialValue: chromaticFSharp)
        
        self._side1 = State(initialValue: side1)
        self._side2 = State(initialValue: side2)
        self._side3 = State(initialValue: side3)
        
        self._highFSharp = State(initialValue: highFSharp)
        
        self._fork = State(initialValue: fork)
        
        self._top1 = State(initialValue: top1)
        self._top2 = State(initialValue: top2)
        self._top3 = State(initialValue: top3)
        
        self._low1 = State(initialValue: low1)
        self._low2 = State(initialValue: low2)
        self._low3 = State(initialValue: low3)
        self._low4 = State(initialValue: low4)
        
        self._bis = State(initialValue: bis)
        
        self._octave = State(initialValue: octave)
        
        self._lowA = State(initialValue: lowA)
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .bottom, spacing: 38) {
                        VStack(alignment: .leading, spacing: 2) {
                            Image("SaxophoneTopLeverKey\(top1 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .padding(.leading, 16)
                                .onTapGesture {
                                    top1.toggle()
                                }
                            
                            VStack(alignment: .leading, spacing: -2) {
                                Image("SaxophoneTopLeverKey\(top2 ? "Full" : "Empty")")
                                    .renderingMode(.template)
                                    .onTapGesture {
                                        top2.toggle()
                                    }
                                Image("SaxophoneTopLeverKey\(top3 ? "Full" : "Empty")")
                                    .renderingMode(.template)
                                    .padding(.leading, 10)
                                    .onTapGesture {
                                        top3.toggle()
                                    }
                            }
                        }
                        
                        HStack(alignment: .bottom, spacing: -4) {
                            Image("SaxophoneUpperLowKey\(low4 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    low4.toggle()
                                }
                            Image("SaxophoneMiddleLowKeys\(low2 ? "Full" : "Empty")\(low3 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .padding(.bottom, 2)
                                .onTapGesture {
                                    if !low2 && !low3 || !low2 && low3 {
                                        low2.toggle()
                                    } else {
                                        low2.toggle()
                                        low3.toggle()
                                    }
                                }
                            Image("SaxophoneBottomLowKey\(low1 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .padding(.bottom, 4)
                                .onTapGesture {
                                    low1.toggle()
                                }
                        }
                    }
                    .padding(.leading, 18)
                    
                    HStack(spacing: 8) {
                        HStack(spacing: 2) {
                            Image("SaxophoneForkKey\(fork ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    fork.toggle()
                                }
                            Image("SaxophoneCircleKey\(key1 ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    key1.toggle()
                                }
                        }
                        
                        Image("SaxophoneCircleKey\(key2 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                key2.toggle()
                            }
                        Image("SaxophoneCircleKeyWithLine\(key3 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                key3.toggle()
                            }
                        Image("SaxophoneCircleKey\(key4 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                key4.toggle()
                            }
                        Image("SaxophoneCircleKey\(key5 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                key5.toggle()
                            }
                        Image("SaxophoneCircleKey\(key6 ? "Full" : "Empty")")
                            .renderingMode(.template)
                            .onTapGesture {
                                key6.toggle()
                            }
                    }
                    
                    HStack(alignment: .bottom, spacing: 71) {
                        HStack(spacing: -2) {
                            Image("SaxophoneOctaveKey\(octave ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    octave.toggle()
                                }

                            Image("SaxophoneBaritoneOctaveKey\(lowA ? "Full" : "Empty")")
                                .renderingMode(.template)
                                .onTapGesture {
                                    lowA.toggle()
                                }
                        }
                        
                        HStack(alignment: .bottom, spacing: 12) {
                            HStack(spacing: 4) {
                                VStack(alignment: .trailing, spacing: 10) {
                                    Image("SaxophoneHighF#Key\(highFSharp ? "Full" : "Empty")")
                                        .renderingMode(.template)
                                        .onTapGesture {
                                            highFSharp.toggle()
                                        }
                                    
                                    HStack(spacing: 2) {
                                        Image("SaxophoneLargeSideKey\(side3 ? "Full" : "Empty")")
                                            .renderingMode(.template)
                                            .onTapGesture {
                                                side3.toggle()
                                            }
                                        Image("SaxophoneSmallSideKey\(side2 ? "Full" : "Empty")")
                                            .renderingMode(.template)
                                            .onTapGesture {
                                                side2.toggle()
                                            }
                                        Image("SaxophoneSmallSideKey\(side1 ? "Full" : "Empty")")
                                            .renderingMode(.template)
                                            .onTapGesture {
                                                side1.toggle()
                                            }
                                    }
                                }
                                
                                Image("SaxophoneChromaticF#Key\(chromaticFSharp ? "Full" : "Empty")")
                                    .renderingMode(.template)
                                    .onTapGesture {
                                        chromaticFSharp.toggle()
                                    }
                            }
                            
                            HStack(spacing: 2) {
                                Image("SaxophoneBottomKey2\(bottom2 ? "Full" : "Empty")")
                                    .renderingMode(.template)
                                    .onTapGesture {
                                        bottom2.toggle()
                                    }
                                Image("SaxophoneBottomKey1\(bottom1 ? "Full" : "Empty")")
                                    .renderingMode(.template)
                                    .onTapGesture {
                                        bottom1.toggle()
                                    }
                            }
                        }
                    }
                }
                
                Image("SaxophoneBisKey\(bis ? "Full" : "Empty")")
                    .renderingMode(.template)
                    .padding(.top, 68)
                    .padding(.leading, 48)
                    .onTapGesture {
                        bis.toggle()
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
                        fingering.keys = [key1, key2, key3, key4, key5, key6, bottom1, bottom2, chromaticFSharp, side1, side2, side3, highFSharp, fork, top1, top2, top3, low1, low2, low3, low4, bis, octave]
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

struct AddBaritoneSaxophoneFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddBaritoneSaxophoneFingeringView(isAdd: true, fingering: .constant(Fingering()), key1: false, key2: false, key3: false, key4: false, key5: false, key6: false, bottom1: false, bottom2: false, chromaticFSharp: false, side1: false, side2: false, side3: false, highFSharp: false, fork: false, top1: false, top2: false, top3: false, low1: false, low2: false, low3: false, low4: false, bis: false, octave: false, lowA: false)
            
            AddBaritoneSaxophoneFingeringView(isAdd: false, fingering: .constant(Fingering()), key1: true, key2: true, key3: true, key4: true, key5: true, key6: true, bottom1: true, bottom2: true, chromaticFSharp: true, side1: true, side2: true, side3: true, highFSharp: true, fork: true, top1: true, top2: true, top3: true, low1: true, low2: true, low3: true, low4: true, bis: true, octave: true, lowA: true)
        }
        .environmentObject(HelperChartsController.shared)
    }
}

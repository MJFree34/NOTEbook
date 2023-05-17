//
//  SaxophoneFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/17/23.
//

import SwiftUI

struct SaxophoneFingeringView: View {
    let fingering: Fingering
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom, spacing: 38) {
                    VStack(alignment: .leading, spacing: 2) {
                        Image("SaxophoneTopLeverKey\(fingering.keys![16] ? "Full" : "Empty")")
                            .padding(.leading, 16)
                        
                        VStack(alignment: .leading, spacing: -2) {
                            Image("SaxophoneTopLeverKey\(fingering.keys![15] ? "Full" : "Empty")")
                            Image("SaxophoneTopLeverKey\(fingering.keys![14] ? "Full" : "Empty")")
                                .padding(.leading, 10)
                        }
                    }
                    
                    HStack(alignment: .bottom, spacing: -4) {
                        Image("SaxophoneUpperLowKey\(fingering.keys![20] ? "Full" : "Empty")")
                        Image("SaxophoneMiddleLowKeys\(fingering.keys![18] ? "Full" : "Empty")\(fingering.keys![19] ? "Full" : "Empty")")
                            .padding(.bottom, 2)
                        Image("SaxophoneBottomLowKey\(fingering.keys![17] ? "Full" : "Empty")")
                            .padding(.bottom, 4)
                    }
                }
                .padding(.leading, 18)
                
                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        Image("SaxophoneForkKey\(fingering.keys![13] ? "Full" : "Empty")")
                        Image("SaxophoneCircleKey\(fingering.keys![0] ? "Full" : "Empty")")
                    }
                    
                    Image("SaxophoneCircleKey\(fingering.keys![1] ? "Full" : "Empty")")
                    Image("SaxophoneCircleKeyWithLine\(fingering.keys![2] ? "Full" : "Empty")")
                    Image("SaxophoneCircleKey\(fingering.keys![3] ? "Full" : "Empty")")
                    Image("SaxophoneCircleKey\(fingering.keys![4] ? "Full" : "Empty")")
                    Image("SaxophoneCircleKey\(fingering.keys![5] ? "Full" : "Empty")")
                }
                
                HStack(alignment: .bottom, spacing: 86) {
                    Image("SaxophoneOctaveKey\(fingering.keys![22] ? "Full" : "Empty")")
                    
                    HStack(alignment: .bottom, spacing: 12) {
                        HStack(spacing: 4) {
                            VStack(alignment: .trailing, spacing: 10) {
                                Image("SaxophoneHighF#Key\(fingering.keys![12] ? "Full" : "Empty")")
                                
                                HStack(spacing: 2) {
                                    Image("SaxophoneLargeSideKey\(fingering.keys![11] ? "Full" : "Empty")")
                                    Image("SaxophoneSmallSideKey\(fingering.keys![10] ? "Full" : "Empty")")
                                    Image("SaxophoneSmallSideKey\(fingering.keys![9] ? "Full" : "Empty")")
                                }
                            }
                            
                            Image("SaxophoneChromaticF#Key\(fingering.keys![8] ? "Full" : "Empty")")
                        }
                        
                        HStack(spacing: 2) {
                            Image("SaxophoneBottomKey2\(fingering.keys![7] ? "Full" : "Empty")")
                            Image("SaxophoneBottomKey1\(fingering.keys![6] ? "Full" : "Empty")")
                        }
                    }
                }
            }
            
            Image("SaxophoneBisKey\(fingering.keys![21] ? "Full" : "Empty")")
                .padding(.top, 68)
                .padding(.leading, 48)
        }
    }
}

struct SaxophoneFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                SaxophoneFingeringView(fingering: Fingering(keys: [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]))
                
                SaxophoneFingeringView(fingering: Fingering(keys: [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]))
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

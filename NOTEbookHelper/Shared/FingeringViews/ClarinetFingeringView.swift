//
//  ClarinetFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/15/23.
//

import SwiftUI

struct ClarinetFingeringView: View {
    let fingering: Fingering
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 2) {
                Image("ClarinetTopLeverKey\(fingering.keys![13] ? "Full" : "Empty")")
                    .padding(.leading, 16)
                    .padding(.top, 24)
                
                HStack(spacing: 12) {
                    HStack(spacing: 2) {
                        Image("ClarinetTopLeverKey\(fingering.keys![14] ? "Full" : "Empty")")
                        
                        Image("ClarinetCircleKey\(fingering.keys![0] ? "Full" : "Empty")")
                    }
                    
                    Image("ClarinetCircleKey\(fingering.keys![1] ? "Full" : "Empty")")
                    Image("ClarinetCircleKey\(fingering.keys![2] ? "Full" : "Empty")")
                    Image("ClarinetCircleKey\(fingering.keys![3] ? "Full" : "Empty")")
                        .padding(.leading, 10)
                    Image("ClarinetCircleKey\(fingering.keys![4] ? "Full" : "Empty")")
                    Image("ClarinetCircleKey\(fingering.keys![5] ? "Full" : "Empty")")
                        .padding(.trailing, 26)
                }
                
                HStack(alignment: .bottom, spacing: 44) {
                    Image("ClarinetThumbKeys\(fingering.keys![22] ? "Full" : "Empty")\(fingering.keys![23] ? "Full" : "Empty")")
                        .padding(.leading, 14)
                    
                    HStack(alignment: .bottom, spacing: 0) {
                        Image("ClarinetSmallSideKey\(fingering.keys![21] ? "Full" : "Empty")")
                        Image("ClarinetSmallSideKey\(fingering.keys![20] ? "Full" : "Empty")")
                        Image("ClarinetLargeSideKey\(fingering.keys![19] ? "Full" : "Empty")")
                        Image("ClarinetLargeSideKey\(fingering.keys![18] ? "Full" : "Empty")")
                    }
                }
            }
            
            HStack(alignment: .top, spacing: 32) {
                Image("ClarinetThinRightLeverKey\(fingering.keys![12] ? "Full" : "Empty")")
                
                Image("ClarinetMiddleLeverKey\(fingering.keys![11] ? "Full" : "Empty")")
            }
            .padding(.top, 28)
            .padding(.trailing, 142)
            
            HStack(spacing: 33) {
                Image("ClarinetThinLeftLeverKey\(fingering.keys![10] ? "Full" : "Empty")")
                
                HStack(spacing: 2) {
                    Image("ClarinetBottomKeys\(fingering.keys![8] ? "Full" : "Empty")\(fingering.keys![9] ? "Full" : "Empty")")
                    Image("ClarinetBottomKeys\(fingering.keys![6] ? "Full" : "Empty")\(fingering.keys![7] ? "Full" : "Empty")")
                }
            }
            .padding(.top, 44)
            
            HStack(alignment: .top, spacing: -8) {
                Image("ClarinetTriggerKey3\(fingering.keys![17] ? "Full" : "Empty")")
                    .padding(.top, 4)
                
                VStack(alignment: .trailing, spacing: 2) {
                    Image("ClarinetTriggerKey1\(fingering.keys![15] ? "Full" : "Empty")")
                    Image("ClarinetTriggerKey2\(fingering.keys![16] ? "Full" : "Empty")")
                        .padding(.trailing, 6)
                }
            }
            .padding(.trailing, 56)
        }
    }
}

struct ClarinetFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                ClarinetFingeringView(fingering: Fingering(keys: [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]))
                
                ClarinetFingeringView(fingering: Fingering(keys: [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]))
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

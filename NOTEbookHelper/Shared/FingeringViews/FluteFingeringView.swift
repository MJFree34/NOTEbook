//
//  FluteFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/14/23.
//

import SwiftUI

struct FluteFingeringView: View {
    let fingering: Fingering
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(alignment: .top, spacing: 0) {
                VStack(spacing: 2) {
                    HStack(spacing: 5) {
                        Image("FluteCircleKey\(fingering.keys![0] ? "Full" : "Empty")")
                        Image("FluteCircleKey\(fingering.keys![1] ? "Full" : "Empty")")
                        Image("FluteCircleKey\(fingering.keys![2] ? "Full" : "Empty")")
                    }
                    
                    Image("FluteThumbKeys\(fingering.keys![14] ? "Full" : "Empty")\(fingering.keys![15] ? "Full" : "Empty")")
                }
                
                VStack(spacing: -8) {
                    HStack(spacing: 5) {
                        Image("FluteCircleKey\(fingering.keys![3] ? "Full" : "Empty")")
                        Image("FluteCircleKey\(fingering.keys![4] ? "Full" : "Empty")")
                        Image("FluteCircleKey\(fingering.keys![5] ? "Full" : "Empty")")
                    }
                    
                    HStack(spacing: 23) {
                        Image("FluteTrillKey\(fingering.keys![9] ? "Full" : "Empty")")
                        Image("FluteTrillKey\(fingering.keys![10] ? "Full" : "Empty")")
                    }
                }
                .padding(.leading, 20)
                
                Image("FlutePinkyKey\(fingering.keys![6] ? "Full" : "Empty")")
                    .padding(.leading, 2)
                
                VStack(spacing: 3.5) {
                    Image("FluteFootKey2\(fingering.keys![13] ? "Full" : "Empty")")
                    Image("FluteFootKey2\(fingering.keys![12] ? "Full" : "Empty")")
                    Image("FluteFootKey1\(fingering.keys![11] ? "Full" : "Empty")")
                }
                .padding(.leading, 2)
            }
            
            Image("FluteLeverKeys\(fingering.keys![7] ? "Full" : "Empty")\(fingering.keys![8] ? "Full" : "Empty")")
                .padding(.trailing, 74)
                .padding(.bottom, 6)
        }
    }
}

struct FluteFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                FluteFingeringView(fingering: Fingering(keys: [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]))
                
                FluteFingeringView(fingering: Fingering(keys: [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]))
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

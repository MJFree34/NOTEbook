//
//  FourValveFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/10/23.
//

import SwiftUI

struct FourValveFingeringView: View {
    let fingering: Fingering
    
    var body: some View {
        HStack {
            Image("RoundFingering\(fingering.keys![0] ? "Full" : "Empty")1")
            Image("RoundFingering\(fingering.keys![1] ? "Full" : "Empty")2")
            Image("RoundFingering\(fingering.keys![2] ? "Full" : "Empty")3")
            Image("RoundFingering\(fingering.keys![3] ? "Full" : "Empty")4")
        }
    }
}

struct FourValveFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                FourValveFingeringView(fingering: Fingering(keys: [false, false, false, false]))
                
                FourValveFingeringView(fingering: Fingering(keys: [true, true, true, true]))
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

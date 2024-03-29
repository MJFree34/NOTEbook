//
//  BbTriggerThreeValveFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/14/23.
//

import SwiftUI

struct BbTriggerThreeValveFingeringView: View {
    let fingering: Fingering
    
    var body: some View {
        HStack {
            Image("BbTrigger\(fingering.triggers![0] ? "Full" : "Empty")")
                .renderingMode(.template)
            Image("RoundFingering\(fingering.keys![0] ? "Full" : "Empty")1")
                .renderingMode(.template)
            Image("RoundFingering\(fingering.keys![1] ? "Full" : "Empty")2")
                .renderingMode(.template)
            Image("RoundFingering\(fingering.keys![2] ? "Full" : "Empty")3")
                .renderingMode(.template)
        }
        .foregroundColor(Color("Black"))
    }
}

struct BbTriggerThreeValveFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                BbTriggerThreeValveFingeringView(fingering: Fingering(keys: [false, false, false], triggers: [false]))
                
                BbTriggerThreeValveFingeringView(fingering: Fingering(keys: [true, true, true], triggers: [true]))
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

//
//  ThreeValveFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 11/25/22.
//

import SwiftUI

struct ThreeValveFingeringView: View {
    let fingering: Fingering
    
    var body: some View {
        HStack {
            Image("RoundFingering\(fingering.keys![0] ? "Full" : "Empty")1")
            Image("RoundFingering\(fingering.keys![0] ? "Full" : "Empty")2")
            Image("RoundFingering\(fingering.keys![0] ? "Full" : "Empty")3")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ThreeValveFingeringView(fingering: Fingering(keys: [false, false, false]))
    }
}

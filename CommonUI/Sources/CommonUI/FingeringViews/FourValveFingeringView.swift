//
//  FourValveFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/10/23.
//

import Common
import SwiftUI

public struct FourValveFingeringView: View {
    public let fingering: Fingering

    public var body: some View {
        HStack {
            Image("RoundFingering\(fingering.keys![0] ? "Full" : "Empty")1")
                .renderingMode(.template)
            Image("RoundFingering\(fingering.keys![1] ? "Full" : "Empty")2")
                .renderingMode(.template)
            Image("RoundFingering\(fingering.keys![2] ? "Full" : "Empty")3")
                .renderingMode(.template)
            Image("RoundFingering\(fingering.keys![3] ? "Full" : "Empty")4")
                .renderingMode(.template)
        }
        .foregroundColor(Color("Black"))
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

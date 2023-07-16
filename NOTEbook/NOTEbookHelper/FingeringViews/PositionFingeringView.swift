//
//  PositionFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/10/23.
//

import Common
import SwiftUI

public struct PositionFingeringView: View {
    public let fingering: Fingering

    public var body: some View {
        HStack {
            if fingering.position!.type == .sharp {
                Image("Sharp")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14, height: 30)
            } else if fingering.position!.type == .flat {
                Image("Flat")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14, height: 30)
            } else {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 14, height: 30)
            }

            Text(fingering.position!.value.rawValue)
                .font(.system(size: 40, design: .monospaced))
        }
        .foregroundColor(Color("Black"))
    }
}

struct PositionFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                PositionFingeringView(fingering: Fingering(position: Position(value: .first, type: .flat)))

                PositionFingeringView(fingering: Fingering(position: Position(value: .second, type: .natural)))

                PositionFingeringView(fingering: Fingering(position: Position(value: .third, type: .sharp)))
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

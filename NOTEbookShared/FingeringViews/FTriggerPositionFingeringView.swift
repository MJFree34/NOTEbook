//
//  FTriggerPositionFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/14/23.
//

import SwiftUI

struct FTriggerPositionFingeringView: View {
    let fingering: Fingering
    
    var body: some View {
        HStack {
            Image("FTrigger\(fingering.triggers![0] ? "Full" : "Empty")")
                .renderingMode(.template)
            
            if (fingering.position!.type == .sharp) {
                Image("Sharp")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 14, height: 30)
            } else if (fingering.position!.type == .flat) {
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

struct FTriggerPositionFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                FTriggerPositionFingeringView(fingering: Fingering(position: Position(value: .first, type: .flat), triggers: [false]))
                
                FTriggerPositionFingeringView(fingering: Fingering(position: Position(value: .second, type: .natural), triggers: [true]))
                
                FTriggerPositionFingeringView(fingering: Fingering(position: Position(value: .third, type: .sharp), triggers: [false]))
            }
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

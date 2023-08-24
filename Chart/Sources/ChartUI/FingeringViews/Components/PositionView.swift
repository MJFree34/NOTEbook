//
//  PositionView.swift
//  ChartUI
//
//  Created by Matt Free on 7/19/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

struct PositionView: View {
    @Binding var position: Position
    var isInteractive = false

    var body: some View {
        HStack {
            if isInteractive {
                Picker(selection: $position.type) {
                    Image(Constants.NoteType.flat, bundle: Bundle.module)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 26)
                        .tag(NoteType.flat)
                    Text("")
                        .tag(NoteType.natural)
                    Image(Constants.NoteType.sharp, bundle: Bundle.module)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 26)
                        .tag(NoteType.sharp)
                } label: {
                    Text("Position Type")
                }
                .pickerStyle(.wheel)

                Picker(selection: $position.value) {
                    ForEach(Position.Value.allCases) { positionValue in
                        Text(positionValue.rawValue)
                            .font(.system(size: 30, design: .monospaced))
                            .tag(positionValue)
                    }
                } label: {
                    Text("Position Value")
                }
                .pickerStyle(.wheel)
            } else {
                if position.type == .flat {
                    Image(Constants.NoteType.flat, bundle: Bundle.module)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 30)
                } else if position.type == .natural {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 14, height: 30)
                } else {
                    Image(Constants.NoteType.sharp, bundle: Bundle.module)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 30)
                }

                Text(position.value.rawValue)
                    .font(.system(size: 40, design: .monospaced))
            }
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewBindingWrapper(wrappedBinding: Position(value: .first, type: .natural)) { positionBinding in
                PositionView(position: positionBinding, isInteractive: true)
            }

            PreviewBindingWrapper(wrappedBinding: Position(value: .fourth, type: .sharp)) { positionBinding in
                PositionView(position: positionBinding)
            }
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

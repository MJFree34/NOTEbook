//
//  NoteTypeView.swift
//  ChartUI
//
//  Created by Matt Free on 7/31/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct NoteTypeView: View {
    private let type: NoteType
    private let isOffset: Bool

    public init(type: NoteType, isOffset: Bool = true) {
        self.type = type
        self.isOffset = isOffset
    }

    public var body: some View {
        Group {
            switch type {
            case .flat:
                ResizableImage(Constants.NoteType.flat, bundle: Bundle.module)
                    .frame(height: 44)
                    .offset(y: isOffset ? -10 : 0)
            case .natural:
                ResizableImage(Constants.NoteType.natural, bundle: Bundle.module)
                    .frame(height: 58)
            case .sharp:
                ResizableImage(Constants.NoteType.sharp, bundle: Bundle.module)
                    .frame(height: 58)
            }
        }
        .frame(width: 20, height: 64)
    }
}

struct NoteTypeView_Previews: PreviewProvider {
    static var previews: some View {
        NoteTypeView(type: .flat)
            .previewComponent()
    }
}

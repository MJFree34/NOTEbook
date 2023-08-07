//
//  QuarterNoteView.swift
//  ChartUI
//
//  Created by Matt Free on 7/31/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct QuarterNoteView: View {
    private let type: QuarterNoteType

    public init(type: QuarterNoteType) {
        self.type = type
    }

    public var body: some View {
        Group {
            switch type {
            case .lower:
                ResizableImage(Constants.Note.lowerQuarter, bundle: Bundle.module)
            case .upper:
                ResizableImage(Constants.Note.upperQuarter, bundle: Bundle.module)
            }
        }
        .frame(height: 80)
    }
}

struct QuarterNoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuarterNoteView(type: .lower)
            .previewComponent()
    }
}

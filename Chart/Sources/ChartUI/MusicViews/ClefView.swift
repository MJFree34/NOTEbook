//
//  ClefView.swift
//  ChartUI
//
//  Created by Matt Free on 7/31/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct ClefView: View {
    private let clef: Clef
    private let ratio: Double

    public init(clef: Clef, ratio: Double = 1.0) {
        self.clef = clef
        self.ratio = ratio
    }

    public var body: some View {
        HStack {
            switch clef {
            case .bass:
                ResizableImage(Constants.Clef.bass, bundle: Bundle.module)
                    .frame(height: 64 * ratio)
                    .offset(y: -7 * ratio)
            case .alto:
                ResizableImage(Constants.Clef.alto, bundle: Bundle.module)
                    .frame(height: 82 * ratio)
            case .treble:
                ResizableImage(Constants.Clef.treble, bundle: Bundle.module)
                    .frame(height: 143 * ratio)
                    .offset(y: 1 * ratio)
            }

            Spacer(minLength: 0)
        }
        .frame(width: 56 * ratio, height: 82 * ratio)
    }
}

struct ClefView_Previews: PreviewProvider {
    static var previews: some View {
        ClefView(clef: .treble)
            .previewComponent()
    }
}

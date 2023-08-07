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

    public init(clef: Clef) {
        self.clef = clef
    }

    public var body: some View {
        HStack {
            switch clef {
            case .bass:
                ResizableImage(Constants.Clef.bass, bundle: Bundle.module)
                    .frame(height: 64)
                    .offset(y: -7)
            case .alto:
                ResizableImage(Constants.Clef.alto, bundle: Bundle.module)
                    .frame(height: 82)
            case .treble:
                ResizableImage(Constants.Clef.treble, bundle: Bundle.module)
                    .frame(height: 143)
                    .offset(y: 1)
            }

            Spacer(minLength: 0)
        }
        .frame(width: 56, height: 82)
    }
}

struct ClefView_Previews: PreviewProvider {
    static var previews: some View {
        ClefView(clef: .treble)
            .previewComponent()
    }
}

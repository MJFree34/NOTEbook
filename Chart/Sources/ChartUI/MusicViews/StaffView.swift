//
//  StaffView.swift
//  ChartUI
//
//  Created by Matt Free on 7/31/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct StaffView: View {
    private let spacing: Double
    private let lineHeight: Double

    public init(spacing: Double, lineHeight: Double) {
        self.spacing = spacing
        self.lineHeight = lineHeight
    }

    public var body: some View {
        VStack(spacing: spacing) {
            ForEach(0..<5) { _ in
                Rectangle()
                    .frame(height: lineHeight)
            }
        }
    }
}

struct StaffView_Previews: PreviewProvider {
    static var previews: some View {
        StaffView(spacing: 17, lineHeight: 2)
            .frame(width: 200)
            .previewComponent()
    }
}

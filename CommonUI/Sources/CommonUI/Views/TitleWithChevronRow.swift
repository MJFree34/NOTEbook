//
//  TitleWithChevronRow.swift
//  CommonUI
//
//  Created by Matt Free on 7/26/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct TitleWithChevronRow: View {
    private let title: String
    private var rotateChevron: Bool

    public init(title: String, rotateChevron: Bool = false) {
        self.title = title
        self.rotateChevron = rotateChevron
    }

    public var body: some View {
        HStack {
            Text("\(title)")
                .textCase(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(Color(.tertiaryLabel))
                .font(.caption)
                .bold(false)
                .rotationEffect(.degrees(rotateChevron ? 90 : 0))
        }
    }
}

//
//  CollapsingRow.swift
//  CommonUI
//
//  Created by Matt Free on 7/26/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct CollapsingRow: View {
    private let title: String
    @Binding private var isExpanded: Bool

    public init(title: String, isExpanded: Binding<Bool>) {
        self.title = title
        self._isExpanded = isExpanded
    }

    public var body: some View {
        TitleWithChevronRow(title: title, rotateChevron: isExpanded)
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            .accessibilityAddTraits(.isButton)
    }
}

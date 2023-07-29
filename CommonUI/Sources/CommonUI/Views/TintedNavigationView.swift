//
//  TintedNavigationView.swift
//  CommonUI
//
//  Created by Matt Free on 7/28/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct TintedNavigationView<Content: View>: View {
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        NavigationView {
            content()
        }
        .tint(.theme(.aqua, .foreground))
    }
}

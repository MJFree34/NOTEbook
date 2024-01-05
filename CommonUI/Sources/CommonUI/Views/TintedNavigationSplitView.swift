//
//  TintedNavigationSplitView.swift
//  CommonUI
//
//  Created by Matt Free on 12/27/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct TintedNavigationSplitView<Sidebar: View, Detail: View, Content: View>: View {
    private let sidebar: () -> Sidebar
    private let detail: () -> Detail
    private let content: () -> Content
    private let hasContent: Bool

    public init(@ViewBuilder sidebar: @escaping () -> Sidebar, @ViewBuilder detail: @escaping () -> Detail) where Content == EmptyView {
        self.sidebar = sidebar
        self.detail = detail
        self.content = { EmptyView() }
        self.hasContent = false
    }

    public init(
        @ViewBuilder sidebar: @escaping () -> Sidebar,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder detail: @escaping () -> Detail
    ) {
        self.sidebar = sidebar
        self.detail = detail
        self.content = content
        self.hasContent = true
    }

    public var body: some View {
        if hasContent {
            NavigationSplitView {
                sidebar()
            } content: {
                content()
            } detail: {
                detail()
            }
            .tint(.theme(.aqua, .foreground))
        } else {
            NavigationSplitView {
                sidebar()
            } detail: {
                detail()
            }
            .tint(.theme(.aqua, .foreground))
        }
    }
}

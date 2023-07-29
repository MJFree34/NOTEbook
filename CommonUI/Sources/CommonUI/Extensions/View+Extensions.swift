//
//  View+Extensions.swift
//  CommonUI
//
//  Created by Matt Free on 7/22/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

extension View {
    public func background(theme: Theme, bundle: Bundle = .main) -> some View {
        self
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Gradient.theme(theme, bundle: bundle), ignoresSafeAreaEdges: .all)
    }

    public func padding(_ spacing: Spacing) -> some View {
        self
            .padding(spacing.rawValue)
    }

    public func padding(_ edges: Edge.Set, _ spacing: Spacing) -> some View {
        self
            .padding(edges, spacing.rawValue)
    }

    public func deleteSwipeAction(action: @escaping () -> Void) -> some View {
        self
            .swipeActions(allowsFullSwipe: false) {
                Button(role: .destructive) {
                    action()
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .tint(.red)
            }
    }
}

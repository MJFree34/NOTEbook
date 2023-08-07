//
//  View+Extensions.swift
//  CommonUI
//
//  Created by Matt Free on 7/22/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

extension View {
    public func background(theme: Theme, bundle: Bundle? = nil) -> some View {
        self
            .scrollContentBackground(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Gradient.theme(theme, bundle: bundle), ignoresSafeAreaEdges: .all)
    }

    public func padding(edges: Edge.Set = .all, spacing: Spacing) -> some View {
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

    public func editSwipeAction(action: @escaping () -> Void) -> some View {
        self
            .swipeActions(edge: .leading) {
                Button {
                    action()
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
            }
    }

    public func previewComponent() -> some View {
        self
            .previewLayout(.sizeThatFits)
            .padding()
    }

    public static func theme(_ theme: Theme, _ prominence: Theme.Prominence, bundle: Bundle? = nil) -> Color {
        Color.theme(theme, prominence, bundle: bundle)
    }
}

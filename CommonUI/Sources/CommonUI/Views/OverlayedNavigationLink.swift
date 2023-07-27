//
//  OverlayedNavigationLink.swift
//  CommonUI
//
//  Created by Matt Free on 7/26/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct OverlayedNavigationLink<Destination: View, Label: View>: View {
    private let destination: () -> Destination
    private let label: () -> Label

    public init(@ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }

    public var body: some View {
        ZStack {
            label()

            NavigationLink {
                destination()
            } label: {
                EmptyView()
            }
            .opacity(0)
        }
    }
}

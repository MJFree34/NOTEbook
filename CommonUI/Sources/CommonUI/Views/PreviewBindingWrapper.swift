//
//  PreviewBindingWrapper.swift
//  CommonUI
//
//  Created by Matt Free on 7/18/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct PreviewBindingWrapper<T, Content: View>: View {
    @State private var wrappedBinding: T
    private let content: (Binding<T>) -> Content

    public init(wrappedBinding: T, @ViewBuilder content: @escaping (Binding<T>) -> Content) {
        self._wrappedBinding = State(wrappedValue: wrappedBinding)
        self.content = content
    }

    public var body: some View {
        content($wrappedBinding)
    }
}

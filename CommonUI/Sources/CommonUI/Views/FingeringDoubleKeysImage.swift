//
//  FingeringDoubleKeysImage.swift
//  CommonUI
//
//  Created by Matt Free on 7/18/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct FingeringDoubleKeysImage: View {
    private let imageName: String
    @Binding private var firstIsFull: Bool
    @Binding private var secondIsFull: Bool
    private let isInteractive: Bool
    private let bundle: Bundle?

    public init(
        imageName: String,
        firstIsFull: Binding<Bool>,
        secondIsFull: Binding<Bool>,
        isInteractive: Bool,
        bundle: Bundle? = nil
    ) {
        self.imageName = imageName
        self._firstIsFull = firstIsFull
        self._secondIsFull = secondIsFull
        self.isInteractive = isInteractive
        self.bundle = bundle
    }

    public var body: some View {
        Image("\(imageName)\(firstIsFull ? "Full" : "Empty")\(secondIsFull ? "Full" : "Empty")", bundle: bundle)
            .renderingMode(.template)
            .onTapGesture {
                if isInteractive {
                    if !firstIsFull && !secondIsFull || !firstIsFull && secondIsFull {
                        firstIsFull.toggle()
                    } else {
                        firstIsFull.toggle()
                        secondIsFull.toggle()
                    }
                }
            }
            .accessibilityAddTraits(isInteractive ? .isButton : .isImage)
            .accessibilityHidden(true)
    }
}

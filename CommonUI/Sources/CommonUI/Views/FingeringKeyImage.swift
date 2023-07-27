//
//  FingeringKeyImage.swift
//  CommonUI
//
//  Created by Matt Free on 7/17/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct FingeringKeyImage: View {
    private var imageName: String
    @Binding private var isFull: Bool
    private var isInteractive: Bool
    private var bundle: Bundle?

    public init(imageName: String, isFull: Binding<Bool>, isInteractive: Bool, bundle: Bundle?) {
        self.imageName = imageName
        self._isFull = isFull
        self.isInteractive = isInteractive
        self.bundle = bundle
    }

    public var body: some View {
        Image("\(imageName)\(isFull ? "Full" : "Empty")", bundle: bundle)
            .renderingMode(.template)
            .onTapGesture {
                if isInteractive {
                    isFull.toggle()
                }
            }
            .accessibilityAddTraits(isInteractive ? .isButton : .isImage)
    }
}

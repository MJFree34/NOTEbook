//
//  ResizableImage.swift
//  CommonUI
//
//  Created by Matt Free on 7/30/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct ResizableImage: View {
    private let assetName: String
    private let bundle: Bundle?

    public init(_ assetName: String, bundle: Bundle? = nil) {
        self.assetName = assetName
        self.bundle = bundle
    }

    public var body: some View {
        Image(assetName, bundle: bundle)
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .accessibilityHidden(true)
    }
}

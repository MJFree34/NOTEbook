//
//  VStack+Extensions.swift
//  CommonUI
//
//  Created by Matt Free on 7/23/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

extension VStack {
    public init(alignment: HorizontalAlignment = .center, spacing: Spacing, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.rawValue, content: content)
    }
}

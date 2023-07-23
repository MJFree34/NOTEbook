//
//  View+Extensions.swift
//  CommonUI
//
//  Created by Matt Free on 7/22/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

extension View {
    public func background(theme: Theme) -> some View {
        self
            .background(Gradient.theme(theme), ignoresSafeAreaEdges: .all)
    }
}

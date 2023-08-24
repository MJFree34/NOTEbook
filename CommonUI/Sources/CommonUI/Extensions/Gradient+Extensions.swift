//
//  Gradient+Extensions.swift
//  CommonUI
//
//  Created by Matt Free on 7/22/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

extension Gradient {
    static func theme(_ theme: Theme, bundle: Bundle? = nil) -> LinearGradient {
        LinearGradient(
            colors: [
                .theme(theme, .gradient, bundle: bundle),
                Color("gradient+end", bundle: bundle)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

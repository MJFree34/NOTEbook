//
//  ShapeStyle+Extensions.swift
//  CommonUI
//
//  Created by Matt Free on 7/29/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

extension ShapeStyle where Self == Color {
    public static func theme(_ theme: Theme, _ prominence: Theme.Prominence, bundle: Bundle? = nil) -> Color {
        Color.theme(theme, prominence, bundle: bundle)
    }
}

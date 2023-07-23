//
//  Color+Extensions.swift
//  CommonUI
//
//  Created by Matt Free on 7/9/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

extension Color {
    public static func theme(_ theme: Theme, _ prominence: Theme.Prominence) -> Color {
        Color(theme.rawValue + "+" + prominence.rawValue)
    }
}

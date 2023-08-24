//
//  Color+Extensions.swift
//  NOTEbook
//
//  Created by Matt Free on 7/9/23.
//

import SwiftUI

extension Color {
    static func theme(_ theme: Theme, _ prominence: Theme.Prominence) -> Color {
        Color(theme.rawValue + "+" + prominence.rawValue)
    }
}

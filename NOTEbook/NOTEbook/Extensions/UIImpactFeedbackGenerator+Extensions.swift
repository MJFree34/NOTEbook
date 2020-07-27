//
//  UIImpactFeedbackGenerator+Extensions.swift
//  NOTEbook
//
//  Created by Matt Free on 7/26/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

extension UIImpactFeedbackGenerator {
    static func lightTapticFeedbackOccurred() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    static func mediumTapticFeedbackOccurred() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

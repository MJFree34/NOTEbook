//
//  UIView+Extensions.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

extension UIView {
    func addBackgroundGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.white.cgColor, UIColor(named: "LightestAqua")!.cgColor]
        layer.addSublayer(gradient)
    }
    
    func addLightMediumAquaGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(named: "LightAqua")!.cgColor, UIColor(named: "MediumAqua")!.cgColor]
        layer.addSublayer(gradient)
    }
}

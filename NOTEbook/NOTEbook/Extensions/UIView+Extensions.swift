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
        removeAllSublayers()
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(named: "White")!.cgColor, UIColor(named: "LightestAqua")!.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
    
    func addLightMediumAquaGradient() {
        removeAllSublayers()
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(named: "LightAqua")!.cgColor, UIColor(named: "MediumAqua")!.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
    
    func removeAllSublayers() {
        if let sublayers = layer.sublayers {
            sublayers[0].removeFromSuperlayer()
        }
    }
}

//
//  UIView+Extensions.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

extension UIView {
    private func addBackgroundGradient() {
        removeAllSublayers()
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(named: "White")!.cgColor, UIColor(named: "LightestestAqua")!.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
    
    func addBackground() {
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.gradientEnabled) {
            backgroundColor = nil
            
            addBackgroundGradient()
        } else {
            removeAllSublayers()
            
            backgroundColor = UIColor(named: "LightestestAqua")
        }
    }
    
    func addLightMediumAquaGradient() {
        removeAllSublayers()
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor(named: "LightAqua")!.cgColor, UIColor(named: "MediumAqua")!.cgColor]
        layer.insertSublayer(gradient, at: 0)
    }
    
    private func removeAllSublayers() {
        if let sublayers = layer.sublayers {
            for sublayer in sublayers {
                if let gradientLayer = sublayer as? CAGradientLayer {
                    gradientLayer.removeFromSuperlayer()
                }
            }
        }
    }
}

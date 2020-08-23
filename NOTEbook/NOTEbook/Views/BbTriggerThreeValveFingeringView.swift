//
//  BbTriggerThreeValveFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/23/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class BbTriggerThreeValveFingeringView: ThreeValveFingeringView {
    private lazy var bbTrigger: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.triggers![0] ? "BbTriggerFull" : "BbTriggerEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
//        if fingering.trigger! { // For if do not want to show empty triggers
            addSubview(bbTrigger)
            
            NSLayoutConstraint.activate([
                bbTrigger.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -85 * ratio),
                bbTrigger.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

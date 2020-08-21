//
//  FTriggerPositionFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/21/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FTriggerPositionFingeringView: PositionFingeringView {
    private lazy var fTrigger: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.trigger! ? "FTriggerFull" : "FTriggerEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
//        if fingering.trigger! {
            addSubview(fTrigger)
            
            NSLayoutConstraint.activate([
                fTrigger.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -60 * ratio),
                fTrigger.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

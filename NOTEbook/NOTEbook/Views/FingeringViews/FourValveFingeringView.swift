//
//  FourValveFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FourValveFingeringView: ValveFingeringView {
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
        addSubview(finger1)
        addSubview(finger2)
        addSubview(finger3)
        addSubview(finger4)
        
        NSLayoutConstraint.activate([
            finger1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -67.5 * ratio),
            finger1.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            finger2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -22.5 * ratio),
            finger2.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            finger3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 22.5 * ratio),
            finger3.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            finger4.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 67.5 * ratio),
            finger4.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

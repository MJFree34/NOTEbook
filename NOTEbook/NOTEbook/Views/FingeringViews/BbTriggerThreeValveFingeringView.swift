//
//  BbTriggerThreeValveFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/23/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class BbTriggerThreeValveFingeringView: ThreeValveFingeringView {
    private lazy var bbTrigger = FingeringKeyView(imageName: fingering.triggers![0] ? UIImage.Instruments.Triggers.bbFull : UIImage.Instruments.Triggers.bbEmpty, ratio: ratio)
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
        addSubview(bbTrigger)
        
        NSLayoutConstraint.activate([
            bbTrigger.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -85 * ratio),
            bbTrigger.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

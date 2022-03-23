//
//  FTriggerPositionFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/21/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FTriggerPositionFingeringView: PositionFingeringView {
    private lazy var fTrigger = FingeringKeyView(imageName: fingering.triggers![0] ? UIImage.Instruments.Triggers.fFull : UIImage.Instruments.Triggers.fEmpty, ratio: ratio)
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
        addSubview(fTrigger)
        
        NSLayoutConstraint.activate([
            fTrigger.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -60 * ratio),
            fTrigger.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

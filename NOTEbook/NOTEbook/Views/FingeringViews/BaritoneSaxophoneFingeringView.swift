//
//  BaritoneSaxophoneFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 9/15/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class BaritoneSaxophoneFingeringView: SaxophoneFingeringView {
    private lazy var baritoneOctaveKey = FingeringKeyView(imageName: fingering.keys![23] ? UIImage.Instruments.Saxophone.baritoneOctaveKeyFull :  UIImage.Instruments.Saxophone.baritoneOctaveKeyEmpty, ratio: ratio)
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
        addSubview(baritoneOctaveKey)
        
        NSLayoutConstraint.activate([
            baritoneOctaveKey.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -90 * ratio),
            baritoneOctaveKey.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 40 * ratio)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

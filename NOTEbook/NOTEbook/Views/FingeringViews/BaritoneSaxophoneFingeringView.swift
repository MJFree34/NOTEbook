//
//  BaritoneSaxophoneFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 9/15/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class BaritoneSaxophoneFingeringView: SaxophoneFingeringView {
    private lazy var baritoneOctaveKey: FingeringKeyView = {
        if fingering.keys![22] {
            if fingering.keys![23] {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.baritoneOctaveKeysFull, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.baritoneOctaveKeysEmptyFull, ratio: ratio)
            }
        } else {
            if fingering.keys![23] {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.baritoneOctaveKeysFullEmpty, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.baritoneOctaveKeysEmpty, ratio: ratio)
            }
        }
    }()
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
        octaveKey.isHidden = true
        
        addSubview(baritoneOctaveKey)
        
        NSLayoutConstraint.activate([
            baritoneOctaveKey.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -128 * ratio),
            baritoneOctaveKey.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 33 * ratio)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

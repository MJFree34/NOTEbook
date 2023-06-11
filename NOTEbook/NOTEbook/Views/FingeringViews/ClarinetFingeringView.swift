//
//  ClarinetFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 9/7/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class ClarinetFingeringView: FingeringView {
    private lazy var circleKey1 = FingeringKeyView(imageName: fingering.keys![0] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey2 = FingeringKeyView(imageName: fingering.keys![1] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey3 = FingeringKeyView(imageName: fingering.keys![2] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey4 = FingeringKeyView(imageName: fingering.keys![3] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey5 = FingeringKeyView(imageName: fingering.keys![4] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey6 = FingeringKeyView(imageName: fingering.keys![5] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty, ratio: ratio)
    
    private lazy var bottomKeys1: FingeringKeyView = {
        if fingering.keys![6] {
            if fingering.keys![7] {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.bottomKeysFullFull, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.bottomKeysEmptyFull, ratio: ratio)
            }
        } else {
            if fingering.keys![7] {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.bottomKeysFullEmpty, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.bottomKeysEmptyEmpty, ratio: ratio)
            }
        }
    }()

    private lazy var bottomKeys2: FingeringKeyView = {
        if fingering.keys![8] {
            if fingering.keys![9] {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.bottomKeysFullFull, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.bottomKeysEmptyFull, ratio: ratio)
            }
        } else {
            if fingering.keys![9] {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.bottomKeysFullEmpty, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.bottomKeysEmptyEmpty, ratio: ratio)
            }
        }
    }()
    
    private lazy var leverKey1 = FingeringKeyView(imageName: fingering.keys![10] ? UIImage.Instruments.Clarinet.thinLeftLeverKeyFull : UIImage.Instruments.Clarinet.thinLeftLeverKeyEmpty, ratio: ratio)
    private lazy var leverKey2 = FingeringKeyView(imageName: fingering.keys![11] ? UIImage.Instruments.Clarinet.middleLeverKeyFull : UIImage.Instruments.Clarinet.middleLeverKeyEmpty, ratio: ratio)
    private lazy var leverKey3 = FingeringKeyView(imageName: fingering.keys![12] ? UIImage.Instruments.Clarinet.thinRightLeverKeyFull : UIImage.Instruments.Clarinet.thinRightLeverKeyEmpty, ratio: ratio)
    private lazy var leverKey4 = FingeringKeyView(imageName: fingering.keys![13] ? UIImage.Instruments.Clarinet.topLeverKeyFull : UIImage.Instruments.Clarinet.topLeverKeyEmpty, ratio: ratio)
    private lazy var leverKey5 = FingeringKeyView(imageName: fingering.keys![14] ? UIImage.Instruments.Clarinet.topLeverKeyFull : UIImage.Instruments.Clarinet.topLeverKeyEmpty, ratio: ratio)
    
    private lazy var triggerKey1 = FingeringKeyView(imageName: fingering.keys![15] ? UIImage.Instruments.Clarinet.triggerKey1Full : UIImage.Instruments.Clarinet.triggerKey1Empty, ratio: ratio)
    private lazy var triggerKey2 = FingeringKeyView(imageName: fingering.keys![15] ? UIImage.Instruments.Clarinet.triggerKey2Full : UIImage.Instruments.Clarinet.triggerKey2Empty, ratio: ratio)
    private lazy var triggerKey3 = FingeringKeyView(imageName: fingering.keys![15] ? UIImage.Instruments.Clarinet.triggerKey3Full : UIImage.Instruments.Clarinet.triggerKey3Empty, ratio: ratio)
    
    private lazy var sideKey1 = FingeringKeyView(imageName: fingering.keys![18] ? UIImage.Instruments.Clarinet.largeSideKeyFull : UIImage.Instruments.Clarinet.largeSideKeyEmpty, ratio: ratio)
    private lazy var sideKey2 = FingeringKeyView(imageName: fingering.keys![19] ? UIImage.Instruments.Clarinet.largeSideKeyFull : UIImage.Instruments.Clarinet.largeSideKeyEmpty, ratio: ratio)
    private lazy var sideKey3 = FingeringKeyView(imageName: fingering.keys![20] ? UIImage.Instruments.Clarinet.smallSideKeyFull : UIImage.Instruments.Clarinet.smallSideKeyEmpty, ratio: ratio)
    private lazy var sideKey4 = FingeringKeyView(imageName: fingering.keys![21] ? UIImage.Instruments.Clarinet.smallSideKeyFull : UIImage.Instruments.Clarinet.smallSideKeyEmpty, ratio: ratio)
    
    private lazy var thumbKeys: FingeringKeyView = {
        if fingering.keys![22] {
            if fingering.keys![23] {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.thumbKeysFullFull, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.thumbKeysEmptyFull, ratio: ratio)
            }
        } else {
            if fingering.keys![23] {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.thumbKeysFullEmpty, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Clarinet.thumbKeysEmptyEmpty, ratio: ratio)
            }
        }
    }()
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
        addSubview(circleKey1)
        addSubview(circleKey2)
        addSubview(circleKey3)
        addSubview(circleKey4)
        addSubview(circleKey5)
        addSubview(circleKey6)
        addSubview(bottomKeys1)
        addSubview(bottomKeys2)
        addSubview(leverKey1)
        addSubview(leverKey2)
        addSubview(leverKey3)
        addSubview(leverKey4)
        addSubview(leverKey5)
        addSubview(triggerKey1)
        addSubview(triggerKey2)
        addSubview(triggerKey3)
        addSubview(sideKey1)
        addSubview(sideKey2)
        addSubview(sideKey3)
        addSubview(sideKey4)
        addSubview(thumbKeys)
        
        NSLayoutConstraint.activate([
            circleKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 120 * ratio),
            circleKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 17 * ratio),
            
            circleKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 75 * ratio),
            circleKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 17 * ratio),
            
            circleKey3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 30 * ratio),
            circleKey3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 17 * ratio),
            
            circleKey4.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -25 * ratio),
            circleKey4.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 17 * ratio),
            
            circleKey5.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -70 * ratio),
            circleKey5.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 17 * ratio),
            
            circleKey6.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -115 * ratio),
            circleKey6.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 17 * ratio),
            
            bottomKeys1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 157 * ratio),
            bottomKeys1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 24 * ratio),

            bottomKeys2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 147 * ratio),
            bottomKeys2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 24 * ratio),
            
            leverKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 97 * ratio),
            leverKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 25 * ratio),
            
            leverKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 1.5 * ratio),
            leverKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15.5 * ratio),
            
            leverKey3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -49 * ratio),
            leverKey3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 8.5 * ratio),
            
            leverKey4.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -130 * ratio),
            leverKey4.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8 * ratio),
            
            leverKey5.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -147 * ratio),
            leverKey5.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 17 * ratio),
            
            triggerKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 75 * ratio),
            triggerKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -25 * ratio),
            
            triggerKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 68 * ratio),
            triggerKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -4 * ratio),
            
            triggerKey3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 42 * ratio),
            triggerKey3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -22 * ratio),
            
            sideKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 11 * ratio),
            sideKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 52 * ratio),
            
            sideKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -1 * ratio),
            sideKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 52 * ratio),
            
            sideKey3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -13 * ratio),
            sideKey3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 54 * ratio),
            
            sideKey4.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -25 * ratio),
            sideKey4.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 54 * ratio),
            
            thumbKeys.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -110 * ratio),
            thumbKeys.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 50 * ratio),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

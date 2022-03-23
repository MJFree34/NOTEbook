//
//  SaxophoneFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 9/14/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class SaxophoneFingeringView: FingeringView {
    private lazy var circleKey1 = FingeringKeyView(imageName: fingering.keys![0] ? UIImage.Instruments.Saxophone.circleKeyFull :  UIImage.Instruments.Saxophone.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey2 = FingeringKeyView(imageName: fingering.keys![1] ? UIImage.Instruments.Saxophone.circleKeyFull :  UIImage.Instruments.Saxophone.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey3 = FingeringKeyView(imageName: fingering.keys![2] ? UIImage.Instruments.Saxophone.circleKeyFull :  UIImage.Instruments.Saxophone.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey4 = FingeringKeyView(imageName: fingering.keys![3] ? UIImage.Instruments.Saxophone.circleKeyWithLineFull :  UIImage.Instruments.Saxophone.circleKeyWithLineEmpty, ratio: ratio)
    private lazy var circleKey5 = FingeringKeyView(imageName: fingering.keys![4] ? UIImage.Instruments.Saxophone.circleKeyFull :  UIImage.Instruments.Saxophone.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey6 = FingeringKeyView(imageName: fingering.keys![5] ? UIImage.Instruments.Saxophone.circleKeyFull :  UIImage.Instruments.Saxophone.circleKeyEmpty, ratio: ratio)
    
    private lazy var bottomKeys: FingeringKeyView = {
        if fingering.keys![6] {
            if fingering.keys![7] {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.bottomKeysFull, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.bottomKeysEmptyFull, ratio: ratio)
            }
        } else {
            if fingering.keys![7] {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.bottomKeysFullEmpty, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.bottomKeysEmpty, ratio: ratio)
            }
        }
    }()
    
    private lazy var sideKey1 = FingeringKeyView(imageName: fingering.keys![8] ? UIImage.Instruments.Saxophone.chromaticFSharpKeyFull :  UIImage.Instruments.Saxophone.chromaticFSharpKeyEmpty, ratio: ratio)
    private lazy var sideKey2 = FingeringKeyView(imageName: fingering.keys![9] ? UIImage.Instruments.Saxophone.smallSideKeyFull :  UIImage.Instruments.Saxophone.smallSideKeyEmpty, ratio: ratio)
    private lazy var sideKey3 = FingeringKeyView(imageName: fingering.keys![10] ? UIImage.Instruments.Saxophone.smallSideKeyFull :  UIImage.Instruments.Saxophone.smallSideKeyEmpty, ratio: ratio)
    private lazy var sideKey4 = FingeringKeyView(imageName: fingering.keys![11] ? UIImage.Instruments.Saxophone.largeSideKeyFull :  UIImage.Instruments.Saxophone.largeSideKeyEmpty, ratio: ratio)
    private lazy var leverKey1 = FingeringKeyView(imageName: fingering.keys![12] ? UIImage.Instruments.Saxophone.highFSharpKeyFull :  UIImage.Instruments.Saxophone.highFSharpKeyEmpty, ratio: ratio)
    private lazy var leverKey2 = FingeringKeyView(imageName: fingering.keys![13] ? UIImage.Instruments.Saxophone.forkKeyFull :  UIImage.Instruments.Saxophone.forkKeyEmpty, ratio: ratio)
    private lazy var leverKey3 = FingeringKeyView(imageName: fingering.keys![14] ? UIImage.Instruments.Saxophone.topLeverKeyFull :  UIImage.Instruments.Saxophone.topLeverKeyEmpty, ratio: ratio)
    private lazy var leverKey4 = FingeringKeyView(imageName: fingering.keys![15] ? UIImage.Instruments.Saxophone.topLeverKeyFull :  UIImage.Instruments.Saxophone.topLeverKeyEmpty, ratio: ratio)
    private lazy var leverKey5 = FingeringKeyView(imageName: fingering.keys![16] ? UIImage.Instruments.Saxophone.topLeverKeyFull :  UIImage.Instruments.Saxophone.topLeverKeyEmpty, ratio: ratio)
    private lazy var rightBottomGroup = FingeringKeyView(imageName: fingering.keys![17] ? UIImage.Instruments.Saxophone.bottomLowKeyFull :  UIImage.Instruments.Saxophone.bottomLowKeyEmpty, ratio: ratio)
    
    private lazy var rightMiddleGroup: FingeringKeyView = {
        if fingering.keys![18] {
            if fingering.keys![19] {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.middleLowKeysFull, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.middleLowKeysFullEmpty, ratio: ratio)
            }
        } else {
            if fingering.keys![19] {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.middleLowKeysEmptyFull, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Saxophone.middleLowKeysEmpty, ratio: ratio)
            }
        }
    }()
    
    private lazy var rightTopGroup = FingeringKeyView(imageName: fingering.keys![20] ? UIImage.Instruments.Saxophone.upperLowKeyFull :  UIImage.Instruments.Saxophone.upperLowKeyEmpty, ratio: ratio)
    private lazy var bisKey = FingeringKeyView(imageName: fingering.keys![21] ? UIImage.Instruments.Saxophone.bisKeyFull :  UIImage.Instruments.Saxophone.bisKeyEmpty, ratio: ratio)
    lazy var octaveKey = FingeringKeyView(imageName: fingering.keys![22] ? UIImage.Instruments.Saxophone.octaveKeyFull :  UIImage.Instruments.Saxophone.octaveKeyEmpty, ratio: ratio)
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
        addSubview(circleKey1)
        addSubview(circleKey2)
        addSubview(circleKey3)
        addSubview(circleKey4)
        addSubview(circleKey5)
        addSubview(circleKey6)
        addSubview(bottomKeys)
        addSubview(sideKey1)
        addSubview(sideKey2)
        addSubview(sideKey3)
        addSubview(sideKey4)
        addSubview(leverKey1)
        addSubview(leverKey2)
        addSubview(leverKey3)
        addSubview(leverKey4)
        addSubview(leverKey5)
        addSubview(rightBottomGroup)
        addSubview(rightMiddleGroup)
        addSubview(rightTopGroup)
        addSubview(bisKey)
        addSubview(octaveKey)
        
        NSLayoutConstraint.activate([
            circleKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 109 * ratio),
            circleKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2 * ratio),
            
            circleKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 69 * ratio),
            circleKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2 * ratio),
            
            circleKey3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 29 * ratio),
            circleKey3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2 * ratio),
            
            circleKey4.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -15.5 * ratio),
            circleKey4.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2 * ratio),
            
            circleKey5.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -61 * ratio),
            circleKey5.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2 * ratio),
            
            circleKey6.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -101 * ratio),
            circleKey6.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2 * ratio),
            
            bottomKeys.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 134 * ratio),
            bottomKeys.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 28 * ratio),
            
            sideKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 95 * ratio),
            sideKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 28 * ratio),
            
            sideKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 71 * ratio),
            sideKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 40 * ratio),
            
            sideKey3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 51 * ratio),
            sideKey3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 40 * ratio),
            
            sideKey4.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 26 * ratio),
            sideKey4.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 40 * ratio),
            
            leverKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 57 * ratio),
            leverKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 24 * ratio),
            
            leverKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -128 * ratio),
            leverKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 2 * ratio),
            
            leverKey3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -95 * ratio),
            leverKey3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -22.5 * ratio),
            
            leverKey4.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -105 * ratio),
            leverKey4.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -34.5 * ratio),
            
            leverKey5.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -85 * ratio),
            leverKey5.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -49.5 * ratio),
            
            rightBottomGroup.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 11 * ratio),
            rightBottomGroup.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -39 * ratio),
            
            rightMiddleGroup.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 2.5 * ratio),
            rightMiddleGroup.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -37 * ratio),
            
            rightTopGroup.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -13.5 * ratio),
            rightTopGroup.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -34 * ratio),
            
            bisKey.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -81 * ratio),
            bisKey.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20 * ratio),
            
            octaveKey.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -120 * ratio),
            octaveKey.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 33 * ratio),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

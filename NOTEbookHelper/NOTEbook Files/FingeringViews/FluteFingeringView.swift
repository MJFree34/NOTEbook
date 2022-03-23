//
//  FluteFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/29/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FluteFingeringView: FingeringView {
    private lazy var circleKey1 = FingeringKeyView(imageName: fingering.keys![0] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey2 = FingeringKeyView(imageName: fingering.keys![1] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey3 = FingeringKeyView(imageName: fingering.keys![2] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey4 = FingeringKeyView(imageName: fingering.keys![3] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey5 = FingeringKeyView(imageName: fingering.keys![4] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty, ratio: ratio)
    private lazy var circleKey6 = FingeringKeyView(imageName: fingering.keys![5] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty, ratio: ratio)
    private lazy var pinkyKey = FingeringKeyView(imageName: fingering.keys![6] ? UIImage.Instruments.Flute.pinkyKeyFull : UIImage.Instruments.Flute.pinkyKeyEmpty, ratio: ratio)
    
    private lazy var leverKeys: FingeringKeyView = {
        if fingering.keys![7] {
            if fingering.keys![8] {
                return FingeringKeyView(imageName: UIImage.Instruments.Flute.leverKeysFull, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Flute.leverKeysEmptyFull, ratio: ratio)
            }
        } else {
            if fingering.keys![8] {
                return FingeringKeyView(imageName: UIImage.Instruments.Flute.leverKeysFullEmpty, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Flute.leverKeysEmpty, ratio: ratio)
            }
        }
    }()
    
    private lazy var trillKey1 = FingeringKeyView(imageName: fingering.keys![9] ? UIImage.Instruments.Flute.trillKeyFull : UIImage.Instruments.Flute.trillKeyEmpty, ratio: ratio)
    private lazy var trillKey2 = FingeringKeyView(imageName: fingering.keys![10] ? UIImage.Instruments.Flute.trillKeyFull : UIImage.Instruments.Flute.trillKeyEmpty, ratio: ratio)
    private lazy var footKey1 = FingeringKeyView(imageName: fingering.keys![11] ? UIImage.Instruments.Flute.footKey1Full : UIImage.Instruments.Flute.footKey1Empty, ratio: ratio)
    private lazy var footKey2 = FingeringKeyView(imageName: fingering.keys![12] ? UIImage.Instruments.Flute.footKey2Full : UIImage.Instruments.Flute.footKey2Empty, ratio: ratio)
    private lazy var footKey3 = FingeringKeyView(imageName: fingering.keys![13] ? UIImage.Instruments.Flute.footKey2Full : UIImage.Instruments.Flute.footKey2Empty, ratio: ratio)
    
    private lazy var thumbKeys: FingeringKeyView = {
        if fingering.keys![14] {
            if fingering.keys![15] {
                return FingeringKeyView(imageName: UIImage.Instruments.Flute.thumbKeysFull, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Flute.thumbKeysEmptyFull, ratio: ratio)
            }
        } else {
            if fingering.keys![15] {
                return FingeringKeyView(imageName: UIImage.Instruments.Flute.thumbKeysFullEmpty, ratio: ratio)
            } else {
                return FingeringKeyView(imageName: UIImage.Instruments.Flute.thumbKeysEmpty, ratio: ratio)
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
        addSubview(pinkyKey)
        addSubview(leverKeys)
        addSubview(trillKey1)
        addSubview(trillKey2)
        addSubview(footKey1)
        addSubview(footKey2)
        addSubview(footKey3)
        addSubview(thumbKeys)
        
        NSLayoutConstraint.activate([
            circleKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -125 * ratio),
            circleKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5 * ratio),
            
            circleKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -90 * ratio),
            circleKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5 * ratio),
            
            circleKey3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -55 * ratio),
            circleKey3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5 * ratio),
            
            circleKey4.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -5 * ratio),
            circleKey4.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5 * ratio),
            
            circleKey5.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 30 * ratio),
            circleKey5.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5 * ratio),
            
            circleKey6.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 65 * ratio),
            circleKey6.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5 * ratio),
            
            pinkyKey.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 93 * ratio),
            pinkyKey.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5 * ratio),
            
            leverKeys.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -35 * ratio),
            leverKeys.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -5 * ratio),
            
            trillKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 12.5 * ratio),
            trillKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 9 * ratio),
            
            trillKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 47.5 * ratio),
            trillKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 9 * ratio),
            
            footKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 125 * ratio),
            footKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 17.5 * ratio),
            
            footKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 125 * ratio),
            footKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -0.5 * ratio),
            
            footKey3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 125 * ratio),
            footKey3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -11.5 * ratio),
            
            thumbKeys.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -95 * ratio),
            thumbKeys.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 17.5 * ratio),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

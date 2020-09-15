//
//  SaxophoneFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 9/14/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class SaxophoneFingeringView: FingeringView {
    private lazy var circleKey1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![0] ? "SaxophoneCircleKeyFull" : "SaxophoneCircleKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![1] ? "SaxophoneCircleKeyFull" : "SaxophoneCircleKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![2] ? "SaxophoneCircleKeyFull" : "SaxophoneCircleKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey4: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![3] ? "SaxophoneCircleKeyWithLineFull" : "SaxophoneCircleKeyWithLineEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey5: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![4] ? "SaxophoneCircleKeyFull" : "SaxophoneCircleKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey6: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![5] ? "SaxophoneCircleKeyFull" : "SaxophoneCircleKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var bottomKeys: UIImageView = {
        let imageView: UIImageView!
        
        if fingering.keys![6] {
            if fingering.keys![7] {
                imageView = UIImageView(image: UIImage(named: "SaxophoneBottomKeysFull")!.withTintColor(UIColor(named: "Black")!))
            } else {
                imageView = UIImageView(image: UIImage(named: "SaxophoneBottomKeysEmptyFull")!.withTintColor(UIColor(named: "Black")!))
            }
        } else {
            if fingering.keys![7] {
                imageView = UIImageView(image: UIImage(named: "SaxophoneBottomKeysFullEmpty")!.withTintColor(UIColor(named: "Black")!))
            } else {
                imageView = UIImageView(image: UIImage(named: "SaxophoneBottomKeysEmpty")!.withTintColor(UIColor(named: "Black")!))
            }
        }
        
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var sideKey1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![8] ? "SaxophoneChromaticF#KeyFull" : "SaxophoneChromaticF#KeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var sideKey2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![9] ? "SaxophoneSmallSideKeyFull" : "SaxophoneSmallSideKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var sideKey3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![10] ? "SaxophoneSmallSideKeyFull" : "SaxophoneSmallSideKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var sideKey4: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![11] ? "SaxophoneLargeSideKeyFull" : "SaxophoneLargeSideKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKey1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![12] ? "SaxophoneHighF#KeyFull" : "SaxophoneHighF#KeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKey2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![13] ? "SaxophoneForkKeyFull" : "SaxophoneForkKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKey3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![14] ? "SaxophoneTopLeverKeyFull" : "SaxophoneTopLeverKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKey4: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![15] ? "SaxophoneTopLeverKeyFull" : "SaxophoneTopLeverKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKey5: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![16] ? "SaxophoneTopLeverKeyFull" : "SaxophoneTopLeverKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var rightBottomGroup: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![17] ? "SaxophoneBottomLowKeyFull" : "SaxophoneBottomLowKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var rightMiddleGroup: UIImageView = {
        let imageView: UIImageView!
        
        if fingering.keys![18] {
            if fingering.keys![19] {
                imageView = UIImageView(image: UIImage(named: "SaxophoneMiddleLowKeysFull")!.withTintColor(UIColor(named: "Black")!))
            } else {
                imageView = UIImageView(image: UIImage(named: "SaxophoneMiddleLowKeysEmptyFull")!.withTintColor(UIColor(named: "Black")!))
            }
        } else {
            if fingering.keys![19] {
                imageView = UIImageView(image: UIImage(named: "SaxophoneMiddleLowKeysFullEmpty")!.withTintColor(UIColor(named: "Black")!))
            } else {
                imageView = UIImageView(image: UIImage(named: "SaxophoneMiddleLowKeysEmpty")!.withTintColor(UIColor(named: "Black")!))
            }
        }
        
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var rightTopGroup: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![20] ? "SaxophoneUpperLowKeyFull" : "SaxophoneUpperLowKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var bisKey: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![21] ? "SaxophoneBisKeyFull" : "SaxophoneBisKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var octaveKey: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![22] ? "SaxophoneOctaveKeyFull" : "SaxophoneOctaveKeyEmpty"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
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

//
//  ClarinetFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 9/7/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class ClarinetFingeringView: FingeringView {
    private lazy var circleKey1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![0] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![1] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![2] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey4: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![3] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey5: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![4] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey6: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![5] ? UIImage.Instruments.Clarinet.circleKeyFull : UIImage.Instruments.Clarinet.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var bottomKeys1: UIImageView = {
        let imageView: UIImageView!
        
        if fingering.keys![6] {
            if fingering.keys![7] {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.bottomKeysFull)!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.bottomKeysEmptyFull)!.withTintColor(.notebookBlack))
            }
        } else {
            if fingering.keys![7] {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.bottomKeysFullEmpty)!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.bottomKeysEmpty)!.withTintColor(.notebookBlack))
            }
        }
        
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var bottomKeys2: UIImageView = {
        let imageView: UIImageView!
        
        if fingering.keys![8] {
            if fingering.keys![9] {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.bottomKeysFull)!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.bottomKeysEmptyFull)!.withTintColor(.notebookBlack))
            }
        } else {
            if fingering.keys![9] {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.bottomKeysFullEmpty)!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.bottomKeysEmpty)!.withTintColor(.notebookBlack))
            }
        }
        
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKey1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![10] ? UIImage.Instruments.Clarinet.thinLeftLeverKeyFull : UIImage.Instruments.Clarinet.thinLeftLeverKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKey2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![11] ? UIImage.Instruments.Clarinet.middleLeverKeyFull : UIImage.Instruments.Clarinet.middleLeverKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKey3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![12] ? UIImage.Instruments.Clarinet.thinRightLeverKeyFull : UIImage.Instruments.Clarinet.thinRightLeverKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKey4: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![13] ? UIImage.Instruments.Clarinet.topLeverKeyFull : UIImage.Instruments.Clarinet.topLeverKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKey5: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![14] ? UIImage.Instruments.Clarinet.topLeverKeyFull : UIImage.Instruments.Clarinet.topLeverKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var rightKeys: UIImageView = {
        let imageView: UIImageView!
        
        if fingering.keys![15] {
            if fingering.keys![16] {
                if fingering.keys![17] {
                    imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.triggerGroupKeysFull)!.withTintColor(.notebookBlack))
                } else {
                    imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.triggerGroupKeysFullFullEmpty)!.withTintColor(.notebookBlack))
                }
            } else {
                if fingering.keys![17] {
                    imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.triggerGroupKeysFullEmptyFull)!.withTintColor(.notebookBlack))
                } else {
                    imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.triggerGroupKeysFullEmptyEmpty)!.withTintColor(.notebookBlack))
                }
            }
        } else {
            if fingering.keys![16] {
                if fingering.keys![17] {
                    imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.triggerGroupKeysEmptyFullFull)!.withTintColor(.notebookBlack))
                } else {
                    imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.triggerGroupKeysEmptyFullEmpty)!.withTintColor(.notebookBlack))
                }
            } else {
                if fingering.keys![17] {
                    imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.triggerGroupKeysEmptyEmptyFull)!.withTintColor(.notebookBlack))
                } else {
                    imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.triggerGroupKeysEmpty)!.withTintColor(.notebookBlack))
                }
            }
        }
        
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var sideKey1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![18] ? UIImage.Instruments.Clarinet.largeSideKeyFull : UIImage.Instruments.Clarinet.largeSideKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var sideKey2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![19] ? UIImage.Instruments.Clarinet.largeSideKeyFull : UIImage.Instruments.Clarinet.largeSideKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var sideKey3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![20] ? UIImage.Instruments.Clarinet.smallSideKeyFull : UIImage.Instruments.Clarinet.smallSideKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var sideKey4: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![21] ? UIImage.Instruments.Clarinet.smallSideKeyFull : UIImage.Instruments.Clarinet.smallSideKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var thumbKeys: UIImageView = {
        let imageView: UIImageView!
        
        if fingering.keys![22] {
            if fingering.keys![23] {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.thumbKeysFull)!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.thumbKeysEmptyFull)!.withTintColor(.notebookBlack))
            }
        } else {
            if fingering.keys![23] {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.thumbKeysFullEmpty)!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Clarinet.thumbKeysEmpty)!.withTintColor(.notebookBlack))
            }
        }
        
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
        addSubview(bottomKeys1)
        addSubview(bottomKeys2)
        addSubview(leverKey1)
        addSubview(leverKey2)
        addSubview(leverKey3)
        addSubview(leverKey4)
        addSubview(leverKey5)
        addSubview(rightKeys)
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
            
            rightKeys.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 63 * ratio),
            rightKeys.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -13 * ratio),
            
            sideKey1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 11 * ratio),
            sideKey1.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 52 * ratio),
            
            sideKey2.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -1 * ratio),
            sideKey2.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 52 * ratio),
            
            sideKey3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -13 * ratio),
            sideKey3.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 54 * ratio),
            
            sideKey4.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -25 * ratio),
            sideKey4.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 54 * ratio),
            
            thumbKeys.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -110 * ratio),
            thumbKeys.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 48 * ratio),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

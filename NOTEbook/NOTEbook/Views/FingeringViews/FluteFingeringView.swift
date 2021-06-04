//
//  FluteFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/29/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FluteFingeringView: FingeringView {
    private lazy var circleKey1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![0] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![1] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![2] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey4: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![3] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey5: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![4] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var circleKey6: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![5] ? UIImage.Instruments.Flute.circleKeyFull : UIImage.Instruments.Flute.circleKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var pinkyKey: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![6] ? UIImage.Instruments.Flute.pinkyKeyFull : UIImage.Instruments.Flute.pinkyKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var leverKeys: UIImageView = {
        let imageView: UIImageView!
        
        if fingering.keys![7] {
            if fingering.keys![8] {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Flute.leverKeysFull)!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Flute.leverKeysEmptyFull)!.withTintColor(.notebookBlack))
            }
        } else {
            if fingering.keys![8] {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Flute.leverKeysFullEmpty)!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Flute.leverKeysEmpty)!.withTintColor(.notebookBlack))
            }
        }
        
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var trillKey1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![9] ? UIImage.Instruments.Flute.trillKeyFull : UIImage.Instruments.Flute.trillKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var trillKey2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![10] ? UIImage.Instruments.Flute.trillKeyFull : UIImage.Instruments.Flute.trillKeyEmpty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var footKey1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![11] ? UIImage.Instruments.Flute.footKey1Full : UIImage.Instruments.Flute.footKey1Empty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var footKey2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![12] ? UIImage.Instruments.Flute.footKey2Full : UIImage.Instruments.Flute.footKey2Empty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var footKey3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![13] ? UIImage.Instruments.Flute.footKey2Full : UIImage.Instruments.Flute.footKey2Empty))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var thumbKeys: UIImageView = {
        let imageView: UIImageView!
        
        if fingering.keys![14] {
            if fingering.keys![15] {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Flute.thumbKeysFull)!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Flute.thumbKeysEmptyFull)!.withTintColor(.notebookBlack))
            }
        } else {
            if fingering.keys![15] {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Flute.thumbKeysFullEmpty)!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: UIImage.Instruments.Flute.thumbKeysEmpty)!.withTintColor(.notebookBlack))
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

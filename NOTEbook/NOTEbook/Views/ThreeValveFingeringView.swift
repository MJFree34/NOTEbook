//
//  TrumpetFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class ThreeValveFingeringView: FingeringView {
    lazy var finger1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys[0] ? "RoundFingeringFull1" : "RoundFingeringEmpty1"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var finger2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys[1] ? "RoundFingeringFull2" : "RoundFingeringEmpty2"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var finger3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys[2] ? "RoundFingeringFull3" : "RoundFingeringEmpty3"))!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
        addSubview(finger1)
        addSubview(finger2)
        addSubview(finger3)
        
        NSLayoutConstraint.activate([
            finger1.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -45 * ratio),
            finger1.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            finger2.centerXAnchor.constraint(equalTo: centerXAnchor),
            finger2.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            finger3.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 45 * ratio),
            finger3.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

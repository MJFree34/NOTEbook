//
//  BaritoneSaxophoneFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 9/15/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class BaritoneSaxophoneFingeringView: SaxophoneFingeringView {
    private lazy var baritoneOctaveKey: UIImageView = {
        let imageView: UIImageView!
        
        if fingering.keys![22] {
            if fingering.keys![23] {
                imageView = UIImageView(image: UIImage(named: "SaxophoneBaritoneOctaveKeysFull")!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: "SaxophoneBaritoneOctaveKeysEmptyFull")!.withTintColor(.notebookBlack))
            }
        } else {
            if fingering.keys![23] {
                imageView = UIImageView(image: UIImage(named: "SaxophoneBaritoneOctaveKeysFullEmpty")!.withTintColor(.notebookBlack))
            } else {
                imageView = UIImageView(image: UIImage(named: "SaxophoneBaritoneOctaveKeysEmpty")!.withTintColor(.notebookBlack))
            }
        }
        
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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

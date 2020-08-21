//
//  PositionFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/21/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class PositionFingeringView: FingeringView {
    private lazy var positionLetter: UILabel = {
        let lab = UILabel()
        lab.text = fingering.position?.value.rawValue
        lab.font = UIFont.systemFont(ofSize: 40)
        lab.textAlignment = .center
        lab.textColor = UIColor(named: "Black")
        lab.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        return lab
    }()
    
    private lazy var letterFlatView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "CellFlat")!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var letterSharpView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "CellSharp")!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
        
        addSubview(positionLetter)
        addSubview(letterFlatView)
        addSubview(letterSharpView)
        
        if fingering.position!.type == .sharp {
            letterSharpView.isHidden = false
        } else if fingering.position!.type == .flat {
            letterFlatView.isHidden = false
        }
        
        NSLayoutConstraint.activate([
            positionLetter.centerXAnchor.constraint(equalTo: centerXAnchor),
            positionLetter.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            letterFlatView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -17 * ratio),
            letterFlatView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            letterSharpView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -17 * ratio),
            letterSharpView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

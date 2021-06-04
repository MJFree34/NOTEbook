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
        lab.textColor = .notebookBlack
        lab.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        return lab
    }()
    
    private lazy var letterFlatView = PositionFingeringAccidental(type: .flat, ratio: ratio)
    private lazy var letterSharpView = PositionFingeringAccidental(type: .sharp, ratio: ratio)
    
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
            
            letterFlatView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -38 * ratio),
            letterFlatView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            letterSharpView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -39 * ratio),
            letterSharpView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

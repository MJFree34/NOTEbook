//
//  PositionFingeringAccidental.swift
//  NOTEbook
//
//  Created by Matt Free on 6/3/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class PositionFingeringAccidental: UIImageView {
    init(type: NoteType, ratio: CGFloat) {
        guard type != .natural else { fatalError("Position fingering should not include natural") }
        
        super.init(image: UIImage(named: type == .flat ? UIImage.MusicSymbols.flat : UIImage.MusicSymbols.sharp)!.withTintColor(.notebookBlack))
        
        transform = CGAffineTransform(scaleX: ratio - 0.3, y: ratio - 0.3)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

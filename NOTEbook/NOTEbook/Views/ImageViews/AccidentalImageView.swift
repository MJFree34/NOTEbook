//
//  NotePickerCellAccidental.swift
//  NOTEbook
//
//  Created by Matt Free on 6/6/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class AccidentalImageView: UIImageView {
    init(noteType: NoteType, transformScale: CGFloat = 1, hide: Bool = false) {
        switch noteType {
        case .natural:
            super.init(image: UIImage(named: UIImage.MusicSymbols.natural))
        case .sharp:
            super.init(image: UIImage(named: UIImage.MusicSymbols.sharp))
        case .flat:
            super.init(image: UIImage(named: UIImage.MusicSymbols.flat))
        }
        
        isHidden = hide
        translatesAutoresizingMaskIntoConstraints = false
        transform = CGAffineTransform(scaleX: transformScale, y: transformScale)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

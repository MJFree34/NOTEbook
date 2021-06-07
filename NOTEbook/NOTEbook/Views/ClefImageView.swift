//
//  ClefImageView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/6/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class ClefImageView: UIImageView {
    init(clef: Clef, transformScale: CGFloat) {
        switch clef {
        case .treble:
            super.init(image: UIImage(named: UIImage.MusicSymbols.trebleClef)!.withTintColor(.notebookBlack))
        case .bass:
            super.init(image: UIImage(named: UIImage.MusicSymbols.bassClef)!.withTintColor(.notebookBlack))
        }
        
        transform = CGAffineTransform(scaleX: transformScale, y: transformScale)
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

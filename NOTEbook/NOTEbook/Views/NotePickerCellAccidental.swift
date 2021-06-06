//
//  NotePickerCellAccidental.swift
//  NOTEbook
//
//  Created by Matt Free on 6/6/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class NotePickerCellAccidental: UIImageView {
    init(noteType: NoteType, hide: Bool) {
        switch noteType {
        case .natural:
            fatalError("No natural should be shown")
        case .sharp:
            super.init(image: UIImage(named: UIImage.MusicSymbols.sharp))
        case .flat:
            super.init(image: UIImage(named: UIImage.MusicSymbols.flat))
        }
        
        isHidden = hide
        translatesAutoresizingMaskIntoConstraints = false
        transform = CGAffineTransform(scaleX: NotePickerViewController.spaceBetweenStaffLines / 20, y: NotePickerViewController.spaceBetweenStaffLines / 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  NotePickerCellQuarterNote.swift
//  NOTEbook
//
//  Created by Matt Free on 6/6/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class NotePickerCellQuarterNote: UIImageView {
    init(quarterNoteOrientation: QuarterNoteOrientation, hide: Bool) {
        switch quarterNoteOrientation {
        case .upper:
            super.init(image: UIImage(named: UIImage.MusicSymbols.upperQuarterNote)!.withTintColor(.notebookBlack))
        case .lower:
            super.init(image: UIImage(named: UIImage.MusicSymbols.lowerQuarterNote)!.withTintColor(.notebookBlack))
        }
        
        isHidden = hide
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
        transform = CGAffineTransform(scaleX: NotePickerViewController.spaceBetweenStaffLines / 20, y: NotePickerViewController.spaceBetweenStaffLines / 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

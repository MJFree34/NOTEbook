//
//  CollectionPickerViewCell.swift
//  NOTEbook
//
//  Created by Matt Free on 6/20/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

enum QuarterNoteOrientation {
    case upper, lower
}

class NotePickerCell: UICollectionViewCell {
    static let reuseIdentifier = "NotePickerCell"
    
    var note: Note = Note(letter: .c, type: .natural, octave: .five) {
        didSet {
            reloadViews()
        }
    }
    
    var quarterNoteOrientation: QuarterNoteOrientation = .upper
    
    var upperQuarterNote: UIImageView!
    var lowerQuarterNote: UIImageView!
    var flat: UIImageView!
    var sharp: UIImageView!
    
    var upperQuarterNoteCenterYConstraint: NSLayoutConstraint!
    var lowerQuarterNoteCenterYConstraint: NSLayoutConstraint!
    
    func initialize() {
        if note.octave == .three || (note.octave == .four && note.letter != .b) {
            quarterNoteOrientation = .lower
        }
        
        upperQuarterNote = UIImageView(image: UIImage(named: "UpperQuarterNote"))
        upperQuarterNote.isHidden = quarterNoteOrientation == .lower
        upperQuarterNote.translatesAutoresizingMaskIntoConstraints = false
        upperQuarterNote.accessibilityIdentifier = "upperQuarterNote"
        contentView.addSubview(upperQuarterNote)
        
        lowerQuarterNote = UIImageView(image: UIImage(named: "LowerQuarterNote"))
        lowerQuarterNote.isHidden = quarterNoteOrientation == .upper
        lowerQuarterNote.translatesAutoresizingMaskIntoConstraints = false
        lowerQuarterNote.accessibilityIdentifier = "lowerQuarterNote"
        contentView.addSubview(lowerQuarterNote)
        
        flat = UIImageView(image: UIImage(named: "Flat"))
        flat.isHidden = note.type != .flat
        flat.translatesAutoresizingMaskIntoConstraints = false
        flat.accessibilityIdentifier = "flat"
        contentView.addSubview(flat)
        
        sharp = UIImageView(image: UIImage(named: "Sharp"))
        sharp.isHidden = note.type != .sharp
        sharp.translatesAutoresizingMaskIntoConstraints = false
        sharp.accessibilityIdentifier = "sharp"
        contentView.addSubview(sharp)
        
        upperQuarterNoteCenterYConstraint = upperQuarterNote.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 26.5 + offset())
        upperQuarterNoteCenterYConstraint.isActive = true
        
        lowerQuarterNoteCenterYConstraint = lowerQuarterNote.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -26.5 + offset())
        lowerQuarterNoteCenterYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            upperQuarterNote.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            lowerQuarterNote.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            flat.centerYAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerYAnchor, constant: (quarterNoteOrientation == .upper ? -41 : 12)),
            flat.centerXAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerXAnchor, constant: -26),

            sharp.centerYAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerYAnchor, constant: (quarterNoteOrientation == .upper ? -28 : 28)),
            sharp.centerXAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerXAnchor, constant: -28),
        ])
    }
    
    func reloadViews() {
        if note.octave == .three || (note.octave == .four && note.letter != .b) {
            quarterNoteOrientation = .lower
        }
        
        upperQuarterNote.isHidden = quarterNoteOrientation == .lower
        lowerQuarterNote.isHidden = quarterNoteOrientation == .upper
        flat.isHidden = note.type != .flat
        sharp.isHidden = note.type != .sharp
        
        upperQuarterNoteCenterYConstraint.constant = 26.5 + offset()
        lowerQuarterNoteCenterYConstraint.constant = -26.5 + offset()
        
        contentView.layoutIfNeeded()
    }
    
    func offset() -> CGFloat {
        let spacing = NotePickerViewController.spaceBetweenStaffLines
        
        switch note.octave {
        case .three:
            switch note.letter {
            case .c:
                return spacing * 6.5
            case .d:
                return spacing * 6
            case .e:
                return spacing * 5.5
            case .f:
                return spacing * 5
            case .g:
                return spacing * 4.5
            case .a:
                return spacing * 4
            case .b:
                return spacing * 3.5
            }
        case .four:
            switch note.letter {
            case .c:
                return spacing * 3
            case .d:
                return spacing * 2.5
            case .e:
                return spacing * 2
            case .f:
                return spacing * 1.5
            case .g:
                return spacing
            case .a:
                return spacing * 0.5
            case .b:
                return 0
            }
        case .five:
            switch note.letter {
            case .c:
                return -spacing * 0.5
            case .d:
                return -spacing
            case .e:
                return -spacing * 1.5
            case .f:
                return -spacing * 2
            case .g:
                return -spacing * 2.5
            case .a:
                return -spacing * 3
            case .b:
                return -spacing * 3.5
            }
        case .six:
            switch note.letter {
            case .c:
                return -spacing * 4
            case .d:
                return -spacing * 4.5
            case .e:
                return -spacing * 5
            case .f:
                return -spacing * 6
            case .g, .a, .b:
                break
            }
        case .zero, .one, .two, .seven:
            break
        }
        
        return 0
    }
    
    
    convenience init(note: Note) {
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


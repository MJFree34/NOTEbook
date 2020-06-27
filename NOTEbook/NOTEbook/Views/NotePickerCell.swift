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
    
    var note: Note!
    
    var quarterNoteOrientation: QuarterNoteOrientation = .upper
    
    var upperQuarterNote: UIImageView!
    var lowerQuarterNote: UIImageView!
    var flat: UIImageView!
    var sharp: UIImageView!
    
    var lowerLine4: UIImageView!
    var lowerLine3: UIImageView!
    var lowerLine2: UIImageView!
    var lowerLine1: UIImageView!
    var upperLine1: UIImageView!
    var upperLine2: UIImageView!
    var upperLine3: UIImageView!
    
    var upperQuarterNoteCenterYConstraint: NSLayoutConstraint!
    var lowerQuarterNoteCenterYConstraint: NSLayoutConstraint!
    
    func initialize() {
        let initNote = Note(letter: .c, type: .natural, octave: .five)
        
        if initNote.octave == .three || (initNote.octave == .four && initNote.letter != .b) {
            quarterNoteOrientation = .lower
        }
        
        upperQuarterNote = UIImageView(image: UIImage(named: "UpperQuarterNote")!.withTintColor(UIColor(named: "Black")!))
        upperQuarterNote.isHidden = quarterNoteOrientation == .lower
        upperQuarterNote.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(upperQuarterNote)
        
        lowerQuarterNote = UIImageView(image: UIImage(named: "LowerQuarterNote")!.withTintColor(UIColor(named: "Black")!))
        lowerQuarterNote.isHidden = quarterNoteOrientation == .upper
        lowerQuarterNote.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lowerQuarterNote)
        
        flat = UIImageView(image: UIImage(named: "Flat")!.withTintColor(UIColor(named: "Black")!))
        flat.isHidden = initNote.type != .flat
        flat.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(flat)
        
        sharp = UIImageView(image: UIImage(named: "Sharp")!.withTintColor(UIColor(named: "Black")!))
        sharp.isHidden = initNote.type != .sharp
        sharp.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(sharp)
        
        upperQuarterNoteCenterYConstraint = upperQuarterNote.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 26.5 + noteOffset(standardNote: false))
        upperQuarterNoteCenterYConstraint.isActive = true
        
        lowerQuarterNoteCenterYConstraint = lowerQuarterNote.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -26.5 + noteOffset(standardNote: false))
        lowerQuarterNoteCenterYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            upperQuarterNote.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            lowerQuarterNote.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            flat.centerYAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerYAnchor, constant: (quarterNoteOrientation == .upper ? -41 : 12)),
            flat.centerXAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerXAnchor, constant: -26),

            sharp.centerYAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerYAnchor, constant: (quarterNoteOrientation == .upper ? -28 : 28)),
            sharp.centerXAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerXAnchor, constant: -28),
        ])
        
        configureExtraNoteLines()
    }
    
    func setNote(_ note: Note) {
        self.note = note
    }
    
    func configureExtraNoteLines() {
        let spacing = NotePickerViewController.spaceBetweenStaffLines
        
        lowerLine4 = createExtraStaffLine()
        lowerLine3 = createExtraStaffLine()
        lowerLine2 = createExtraStaffLine()
        lowerLine1 = createExtraStaffLine()
        upperLine1 = createExtraStaffLine()
        upperLine2 = createExtraStaffLine()
        upperLine3 = createExtraStaffLine()
        
        NSLayoutConstraint.activate([
            lowerLine4.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 6),
            lowerLine3.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 5),
            lowerLine2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 4),
            lowerLine1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 3),
            upperLine1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * -3),
            upperLine2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * -4),
            upperLine3.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * -5),
        ])
    }
    
    func createExtraStaffLine() -> UIImageView {
        let extraLineImageView = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 35, height: 2), rounded: true).withTintColor(UIColor(named: "Black")!))
        extraLineImageView.isHidden = true
        extraLineImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(extraLineImageView)
        
        NSLayoutConstraint.activate([
            extraLineImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            extraLineImageView.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        return extraLineImageView
    }
    
    func reloadViews() {
        if note.octave == .three || (note.octave == .four && note.letter != .b) {
            quarterNoteOrientation = .lower
        } else {
            quarterNoteOrientation = .upper
        }
        
        upperQuarterNote.isHidden = quarterNoteOrientation == .lower
        lowerQuarterNote.isHidden = quarterNoteOrientation == .upper
        flat.isHidden = note.type != .flat
        sharp.isHidden = note.type != .sharp
        
        displayExtraNoteLines()
        
        upperQuarterNoteCenterYConstraint.constant = 26.5 + noteOffset()
        lowerQuarterNoteCenterYConstraint.constant = -26.5 + noteOffset()
        
        contentView.layoutIfNeeded()
    }
    
    func displayExtraNoteLines() {
        lowerLine4.isHidden = true
        lowerLine3.isHidden = true
        lowerLine2.isHidden = true
        lowerLine1.isHidden = true
        upperLine1.isHidden = true
        upperLine2.isHidden = true
        upperLine3.isHidden = true
        
        switch note.numberOfExtraLines {
        case 4:
            if note.extraLinesLocation == .top {
                fatalError()
            } else {
                lowerLine4.isHidden = false
                fallthrough
            }
        case 3:
            if note.extraLinesLocation == .top {
                upperLine3.isHidden = false
                fallthrough
            } else {
                lowerLine3.isHidden = false
                fallthrough
            }
        case 2:
            if note.extraLinesLocation == .top {
                upperLine2.isHidden = false
                fallthrough
            } else {
                lowerLine2.isHidden = false
                fallthrough
            }
        case 1:
            if note.extraLinesLocation == .top {
                upperLine1.isHidden = false
            } else {
                lowerLine1.isHidden = false
            }
        default:
            break
        }
    }
    
    func noteOffset(standardNote: Bool = true) -> CGFloat {
        guard standardNote else { return 0 }
        
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
                return -spacing * 5.5
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


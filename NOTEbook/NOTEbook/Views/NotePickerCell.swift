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
    
    var lowerLine8: UIImageView!
    var lowerLine7: UIImageView!
    var lowerLine6: UIImageView!
    var lowerLine5: UIImageView!
    var lowerLine4: UIImageView!
    var lowerLine3: UIImageView!
    var lowerLine2: UIImageView!
    var lowerLine1: UIImageView!
    var upperLine1: UIImageView!
    var upperLine2: UIImageView!
    var upperLine3: UIImageView!
    var upperLine4: UIImageView!
    var upperLine5: UIImageView!
    var upperLine6: UIImageView!
    
    var upperQuarterNoteCenterYConstraint: NSLayoutConstraint!
    var lowerQuarterNoteCenterYConstraint: NSLayoutConstraint!
    
    func initialize() {
        let initNote = Note(letter: .c, type: .natural, pitch: .highMedium, clef: .treble)
        
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
        
        lowerLine8 = createExtraStaffLine()
        lowerLine7 = createExtraStaffLine()
        lowerLine6 = createExtraStaffLine()
        lowerLine5 = createExtraStaffLine()
        lowerLine4 = createExtraStaffLine()
        lowerLine3 = createExtraStaffLine()
        lowerLine2 = createExtraStaffLine()
        lowerLine1 = createExtraStaffLine()
        upperLine1 = createExtraStaffLine()
        upperLine2 = createExtraStaffLine()
        upperLine3 = createExtraStaffLine()
        upperLine4 = createExtraStaffLine()
        upperLine5 = createExtraStaffLine()
        upperLine6 = createExtraStaffLine()
        
        NSLayoutConstraint.activate([
            lowerLine8.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 10),
            lowerLine7.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 9),
            lowerLine6.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 8),
            lowerLine5.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 7),
            lowerLine4.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 6),
            lowerLine3.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 5),
            lowerLine2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 4),
            lowerLine1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * 3),
            upperLine1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * -3),
            upperLine2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * -4),
            upperLine3.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * -5),
            upperLine4.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * -6),
            upperLine5.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * -7),
            upperLine6.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: spacing * -8),
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
        if note.position == .middle2ndSpace || note.position == .middle2ndLine || note.position == .middle1stSpace || note.position == .middle1stLine || note.position.findLocation() == .bottom {
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
        lowerLine8.isHidden = true
        lowerLine7.isHidden = true
        lowerLine6.isHidden = true
        lowerLine5.isHidden = true
        lowerLine4.isHidden = true
        lowerLine3.isHidden = true
        lowerLine2.isHidden = true
        lowerLine1.isHidden = true
        upperLine1.isHidden = true
        upperLine2.isHidden = true
        upperLine3.isHidden = true
        upperLine4.isHidden = true
        upperLine5.isHidden = true
        upperLine6.isHidden = true
        
        switch note.position {
        case .bottom8thLine:
            lowerLine8.isHidden = false
            fallthrough
        case .bottom7thLine, .bottom8thSpace:
            lowerLine7.isHidden = false
            fallthrough
        case .bottom6thLine, .bottom7thSpace:
            lowerLine6.isHidden = false
            fallthrough
        case .bottom5thLine, .bottom6thSpace:
            lowerLine5.isHidden = false
            fallthrough
        case .bottom4thLine, .bottom5thSpace:
            lowerLine4.isHidden = false
            fallthrough
        case .bottom3rdLine, .bottom4thSpace:
            lowerLine3.isHidden = false
            fallthrough
        case .bottom2ndLine, .bottom3rdSpace:
            lowerLine2.isHidden = false
            fallthrough
        case .bottom1stLine, .bottom2ndSpace:
            lowerLine1.isHidden = false
        case .top6thLine:
            upperLine6.isHidden = false
            fallthrough
        case .top5thLine, .top6thSpace:
            upperLine5.isHidden = false
            fallthrough
        case .top4thLine, .top5thSpace:
            upperLine4.isHidden = false
            fallthrough
        case .top3rdLine, .top4thSpace:
            upperLine3.isHidden = false
            fallthrough
        case .top2ndLine, .top3rdSpace:
            upperLine2.isHidden = false
            fallthrough
        case .top1stLine, .top2ndSpace:
            upperLine1.isHidden = false
        default:
            break
        }
    }
    
    func noteOffset(standardNote: Bool = true) -> CGFloat {
        guard standardNote else { return 0 }
        
        let spacing = NotePickerViewController.spaceBetweenStaffLines
        
        switch note.position {
        case .bottom8thLine:
            return spacing * 10
        case .bottom8thSpace:
            return spacing * 9.5
        case .bottom7thLine:
            return spacing * 9
        case .bottom7thSpace:
            return spacing * 8.5
        case .bottom6thLine:
            return spacing * 8
        case .bottom6thSpace:
            return spacing * 7.5
        case .bottom5thLine:
            return spacing * 7
        case .bottom5thSpace:
            return spacing * 6.5
        case .bottom4thLine:
            return spacing * 6
        case .bottom4thSpace:
            return spacing * 5.5
        case .bottom3rdLine:
            return spacing * 5
        case .bottom3rdSpace:
            return spacing * 4.5
        case .bottom2ndLine:
            return spacing * 4
        case .bottom2ndSpace:
            return spacing * 3.5
        case .bottom1stLine:
            return spacing * 3
        case .bottom1stSpace:
            return spacing * 2.5
        case .middle1stLine:
            return spacing * 2
        case .middle1stSpace:
            return spacing * 1.5
        case .middle2ndLine:
            return spacing
        case .middle2ndSpace:
            return spacing * 0.5
        case .middle3rdLine:
            return 0
        case .middle3rdSpace:
            return -spacing * 0.5
        case .middle4thLine:
            return -spacing
        case .middle4thSpace:
            return -spacing * 1.5
        case .middle5thLine:
            return -spacing * 2
        case .top1stSpace:
            return -spacing * 2.5
        case .top1stLine:
            return -spacing * 3
        case .top2ndSpace:
            return -spacing * 3.5
        case .top2ndLine:
            return -spacing * 4
        case .top3rdSpace:
            return -spacing * 4.5
        case .top3rdLine:
            return -spacing * 5
        case .top4thSpace:
            return -spacing * 5.5
        case .top4thLine:
            return -spacing * 6
        case .top5thSpace:
            return -spacing * 6.5
        case .top5thLine:
            return -spacing * 7
        case .top6thSpace:
            return -spacing * 7.5
        case .top6thLine:
            return -spacing * 8
        }
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


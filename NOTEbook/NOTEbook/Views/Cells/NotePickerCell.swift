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
    
    private var upperNoteCenterOffset: CGFloat = 16
    private var lowerNoteCenterOffset: CGFloat = -21
    
    var note: Note!
    
    private var quarterNoteOrientation: QuarterNoteOrientation = .upper
    
    private var upperQuarterNote: UIImageView!
    private var lowerQuarterNote: UIImageView!
    private var flat: UIImageView!
    private var sharp: UIImageView!
    
    private var lowerLine8: UIImageView!
    private var lowerLine7: UIImageView!
    private var lowerLine6: UIImageView!
    private var lowerLine5: UIImageView!
    private var lowerLine4: UIImageView!
    private var lowerLine3: UIImageView!
    private var lowerLine2: UIImageView!
    private var lowerLine1: UIImageView!
    private var upperLine1: UIImageView!
    private var upperLine2: UIImageView!
    private var upperLine3: UIImageView!
    private var upperLine4: UIImageView!
    private var upperLine5: UIImageView!
    private var upperLine6: UIImageView!
    private var upperLine7: UIImageView!
    
    private var upperQuarterNoteCenterYConstraint: NSLayoutConstraint!
    private var lowerQuarterNoteCenterYConstraint: NSLayoutConstraint!
    
    private var lowerLine8CenterYConstraint: NSLayoutConstraint!
    private var lowerLine7CenterYConstraint: NSLayoutConstraint!
    private var lowerLine6CenterYConstraint: NSLayoutConstraint!
    private var lowerLine5CenterYConstraint: NSLayoutConstraint!
    private var lowerLine4CenterYConstraint: NSLayoutConstraint!
    private var lowerLine3CenterYConstraint: NSLayoutConstraint!
    private var lowerLine2CenterYConstraint: NSLayoutConstraint!
    private var lowerLine1CenterYConstraint: NSLayoutConstraint!
    private var upperLine1CenterYConstraint: NSLayoutConstraint!
    private var upperLine2CenterYConstraint: NSLayoutConstraint!
    private var upperLine3CenterYConstraint: NSLayoutConstraint!
    private var upperLine4CenterYConstraint: NSLayoutConstraint!
    private var upperLine5CenterYConstraint: NSLayoutConstraint!
    private var upperLine6CenterYConstraint: NSLayoutConstraint!
    private var upperLine7CenterYConstraint: NSLayoutConstraint!
    
    private func initialize() {
        let initNote = Note(letter: .c, type: .natural, pitch: .highMedium, clef: .treble)
        
        upperQuarterNote = UIImageView(image: UIImage(named: "UpperQuarterNote")!.withTintColor(UIColor(named: "Black")!))
        upperQuarterNote.contentMode = .scaleAspectFill
        upperQuarterNote.isHidden = quarterNoteOrientation == .lower
        upperQuarterNote.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(upperQuarterNote)
        
        lowerQuarterNote = UIImageView(image: UIImage(named: "LowerQuarterNote")!.withTintColor(UIColor(named: "Black")!))
        lowerQuarterNote.contentMode = .scaleAspectFill
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
        
        upperQuarterNoteCenterYConstraint = upperQuarterNote.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: upperNoteCenterOffset + noteOffset(standardNote: false))
        upperQuarterNoteCenterYConstraint.isActive = true
        
        lowerQuarterNoteCenterYConstraint = lowerQuarterNote.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: lowerNoteCenterOffset + noteOffset(standardNote: false))
        lowerQuarterNoteCenterYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            upperQuarterNote.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            lowerQuarterNote.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            flat.centerYAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerYAnchor, constant: (quarterNoteOrientation == .upper ? -29 * NotePickerViewController.spaceBetweenStaffLines / 20 : 0)),
            flat.centerXAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerXAnchor, constant: -26 * NotePickerViewController.spaceBetweenStaffLines / 20),
            
            sharp.centerYAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerYAnchor, constant: (quarterNoteOrientation == .upper ? -16 * NotePickerViewController.spaceBetweenStaffLines / 20 : 16 * NotePickerViewController.spaceBetweenStaffLines / 20)),
            sharp.centerXAnchor.constraint(equalTo: (quarterNoteOrientation == .upper ? upperQuarterNote : lowerQuarterNote)!.centerXAnchor, constant: -28 * NotePickerViewController.spaceBetweenStaffLines / 20),
        ])
        
        initializeExtraNoteLines()
        
        upperQuarterNote.transform = CGAffineTransform(scaleX: NotePickerViewController.spaceBetweenStaffLines / 20, y: NotePickerViewController.spaceBetweenStaffLines / 20)
        lowerQuarterNote.transform = CGAffineTransform(scaleX: NotePickerViewController.spaceBetweenStaffLines / 20, y: NotePickerViewController.spaceBetweenStaffLines / 20)
        sharp.transform = CGAffineTransform(scaleX: NotePickerViewController.spaceBetweenStaffLines / 20, y: NotePickerViewController.spaceBetweenStaffLines / 20)
        flat.transform = CGAffineTransform(scaleX: NotePickerViewController.spaceBetweenStaffLines / 20, y: NotePickerViewController.spaceBetweenStaffLines / 20)
        
        upperNoteCenterOffset *= NotePickerViewController.spaceBetweenStaffLines / 20
        lowerNoteCenterOffset *= NotePickerViewController.spaceBetweenStaffLines / 20
    }
    
    private func initializeExtraNoteLines() {
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
        upperLine7 = createExtraStaffLine()
        
        lowerLine8CenterYConstraint = lowerLine8.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        lowerLine8CenterYConstraint.isActive = true
        lowerLine7CenterYConstraint = lowerLine7.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        lowerLine7CenterYConstraint.isActive = true
        lowerLine6CenterYConstraint = lowerLine6.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        lowerLine6CenterYConstraint.isActive = true
        lowerLine5CenterYConstraint = lowerLine5.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        lowerLine5CenterYConstraint.isActive = true
        lowerLine4CenterYConstraint = lowerLine4.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        lowerLine4CenterYConstraint.isActive = true
        lowerLine3CenterYConstraint = lowerLine3.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        lowerLine3CenterYConstraint.isActive = true
        lowerLine2CenterYConstraint = lowerLine2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        lowerLine2CenterYConstraint.isActive = true
        lowerLine1CenterYConstraint = lowerLine1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        lowerLine1CenterYConstraint.isActive = true
        upperLine1CenterYConstraint = upperLine1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        upperLine1CenterYConstraint.isActive = true
        upperLine2CenterYConstraint = upperLine2.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        upperLine2CenterYConstraint.isActive = true
        upperLine3CenterYConstraint = upperLine3.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        upperLine3CenterYConstraint.isActive = true
        upperLine4CenterYConstraint = upperLine4.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        upperLine4CenterYConstraint.isActive = true
        upperLine5CenterYConstraint = upperLine5.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        upperLine5CenterYConstraint.isActive = true
        upperLine6CenterYConstraint = upperLine6.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        upperLine6CenterYConstraint.isActive = true
        upperLine7CenterYConstraint = upperLine7.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        upperLine7CenterYConstraint.isActive = true
        
        configureExtraNoteLines()
    }
    
    private func configureExtraNoteLines() {
        let spacing = NotePickerViewController.spaceBetweenStaffLines
        let offset = NotePickerViewController.spaceBetweenStaffLines * CGFloat(ChartsController.shared.currentChart.instrument.offset)
        
        lowerLine8CenterYConstraint.constant = spacing * 10 + offset
        lowerLine7CenterYConstraint.constant = spacing * 9 + offset
        lowerLine6CenterYConstraint.constant = spacing * 8 + offset
        lowerLine5CenterYConstraint.constant = spacing * 7 + offset
        lowerLine4CenterYConstraint.constant = spacing * 6 + offset
        lowerLine3CenterYConstraint.constant = spacing * 5 + offset
        lowerLine2CenterYConstraint.constant = spacing * 4 + offset
        lowerLine1CenterYConstraint.constant = spacing * 3 + offset
        upperLine1CenterYConstraint.constant = spacing * -3 + offset
        upperLine2CenterYConstraint.constant = spacing * -4 + offset
        upperLine3CenterYConstraint.constant = spacing * -5 + offset
        upperLine4CenterYConstraint.constant = spacing * -6 + offset
        upperLine5CenterYConstraint.constant = spacing * -7 + offset
        upperLine6CenterYConstraint.constant = spacing * -8 + offset
        upperLine7CenterYConstraint.constant = spacing * -9 + offset
        
        contentView.layoutIfNeeded()
    }
    
    private func createExtraStaffLine() -> UIImageView {
        let extraLineImageView = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 35 * NotePickerViewController.spaceBetweenStaffLines / 20, height: 2), rounded: true).withTintColor(UIColor(named: "Black")!))
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
        configureExtraNoteLines()
        
        upperQuarterNoteCenterYConstraint.constant = upperNoteCenterOffset + noteOffset() + NotePickerViewController.spaceBetweenStaffLines * CGFloat(ChartsController.shared.currentChart.instrument.offset)
        lowerQuarterNoteCenterYConstraint.constant = lowerNoteCenterOffset + noteOffset() + NotePickerViewController.spaceBetweenStaffLines * CGFloat(ChartsController.shared.currentChart.instrument.offset)
        
        contentView.layoutIfNeeded()
    }
    
    private func displayExtraNoteLines() {
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
        upperLine7.isHidden = true
        
        switch note.position {
        case .bottom8thLine, .bottom9thSpace:
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
        case .top7thLine, .top8thSpace:
            upperLine7.isHidden = false
            fallthrough
        case .top6thLine, .top7thSpace:
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
    
    private func noteOffset(standardNote: Bool = true) -> CGFloat {
        guard standardNote else { return 0 }
        
        let spacing = NotePickerViewController.spaceBetweenStaffLines
        
        switch note.position {
        case .bottom9thSpace:
            return spacing * 10.5
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
        case .top7thSpace:
            return -spacing * 8.5
        case .top7thLine:
            return -spacing * 9
        case .top8thSpace:
            return -spacing * 9.5
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


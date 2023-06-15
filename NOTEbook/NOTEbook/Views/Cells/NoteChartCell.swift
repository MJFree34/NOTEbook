//
//  NoteChartCell.swift
//  NOTEbook
//
//  Created by Matt Free on 6/17/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NoteChartCell: UICollectionViewCell {
    static let reuseIdentifier = "NoteChartCell"
    
    private let chartsController = ChartsController.shared
    private let spaceBetweenStaffLines: CGFloat = 10
    
    private var cellHeight: CGFloat!
    private var cellWidth: CGFloat!
    private var centerOfStaffInsetFromTop: CGFloat!
    
    private var noteFingering: NoteFingering!
    private var currentStaffLines = [UIImageView]()
    private var currentOutline = [UIImageView]()
    private var currentExtraLines = [UIImageView]()
    private var currentWholeNotes = [UIImageView]()
    private var currentFingerings = [FingeringView]()
    
    private var trebleClefTopConstraint: NSLayoutConstraint!
    private var bassClefTopConstraint: NSLayoutConstraint!
    
    private lazy var optionalLabel = OptionalLabel(large: false)
    
    private lazy var leftTextView = NoteChartCellTextView(alignment: .left)
    private lazy var rightTextView = NoteChartCellTextView(alignment: .right)
    
    private lazy var letterFlatView = AccidentalImageView(noteType: .flat, transformScale: spaceBetweenStaffLines / 10 - 0.5)
    private lazy var letterSharpView = AccidentalImageView(noteType: .sharp, transformScale: spaceBetweenStaffLines / 10 - 0.5)
    
    private lazy var trebleClef = ClefImageView(clef: .treble, transformScale: spaceBetweenStaffLines / 10 - 0.5)
    private lazy var bassClef = ClefImageView(clef: .bass, transformScale: spaceBetweenStaffLines / 10 - 0.5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(trebleClef)
        contentView.addSubview(bassClef)
        
        NSLayoutConstraint.activate([
            trebleClef.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -14),
            bassClef.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -14),
        ])
        
        trebleClefTopConstraint = trebleClef.topAnchor.constraint(equalTo: contentView.topAnchor)
        bassClefTopConstraint = bassClef.topAnchor.constraint(equalTo: contentView.topAnchor)
        trebleClefTopConstraint.isActive = true
        bassClefTopConstraint.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoteChartCell {
    func configureCell(collectionViewWidth: CGFloat, noteFingering: NoteFingering) {
        self.cellWidth = collectionViewWidth / 3
        self.noteFingering = noteFingering
        centerOfStaffInsetFromTop = CGFloat(chartsController.currentChart.instrument.chartCenterOfStaffFromTop)
        cellHeight = CGFloat(chartsController.chartCellHeight())
        
        configureStaff()
        configureOutline()
        configureNoteLetters()
        configureExtraNoteLines()
        configureNotes()
        configureFingering()
    }
    
    private func configureStaff() {
        for staffLine in currentStaffLines {
            staffLine.removeFromSuperview()
        }
        
        currentStaffLines.removeAll()
        
        for i in -2...2 {
            addStaffLine(topInset: centerOfStaffInsetFromTop + spaceBetweenStaffLines * CGFloat(i))
        }
        
        if chartsController.currentChart.centerNote!.clef == .treble {
            trebleClef.isHidden = false
            bassClef.isHidden = true
        } else {
            trebleClef.isHidden = true
            bassClef.isHidden = false
        }
        
        trebleClefTopConstraint.constant = centerOfStaffInsetFromTop - (7.62 * spaceBetweenStaffLines)
        bassClefTopConstraint.constant = centerOfStaffInsetFromTop - (3.5 * spaceBetweenStaffLines)
        
        contentView.layoutIfNeeded()
    }
    
    private func addStaffLine(topInset: CGFloat) {
        let staffImageView = UIImageView(image: UIImage.drawStaffLine(color: .notebookBlack, size: CGSize(width: cellWidth, height: 1), rounded: false).withTintColor(.notebookBlack))
        staffImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(staffImageView)
        
        NSLayoutConstraint.activate([
            staffImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
            staffImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
        
        currentStaffLines.append(staffImageView)
    }
    
    private func configureOutline() {
        for outline in currentOutline {
            outline.removeFromSuperview()
        }
        
        currentOutline.removeAll()
        
        let insetFromTop = centerOfStaffInsetFromTop - 2 * spaceBetweenStaffLines
        
        let leftOutline = UIImageView(image: UIImage.drawStaffLine(color: .notebookBlack, size: CGSize(width: 0.5, height: cellHeight - insetFromTop), rounded: false).withTintColor(.notebookBlack))
        leftOutline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(leftOutline)
        currentOutline.append(leftOutline)
        
        let bottomOutline = UIImageView(image: UIImage.drawStaffLine(color: .notebookBlack, size: CGSize(width: cellWidth, height: 1), rounded: false).withTintColor(.notebookBlack))
        bottomOutline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bottomOutline)
        currentOutline.append(bottomOutline)
        
        let rightOutline = UIImageView(image: UIImage.drawStaffLine(color: .notebookBlack, size: CGSize(width: 0.5, height: cellHeight - insetFromTop), rounded: false).withTintColor(.notebookBlack))
        rightOutline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rightOutline)
        currentOutline.append(rightOutline)
        
        NSLayoutConstraint.activate([
            leftOutline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -0.1),
            leftOutline.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insetFromTop),
            leftOutline.heightAnchor.constraint(equalToConstant: cellHeight - insetFromTop),
            leftOutline.widthAnchor.constraint(equalToConstant: 0.5),
            
            bottomOutline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomOutline.heightAnchor.constraint(equalToConstant: 1),
            bottomOutline.widthAnchor.constraint(equalToConstant: cellWidth),
            
            rightOutline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rightOutline.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insetFromTop),
            rightOutline.heightAnchor.constraint(equalToConstant: cellHeight - insetFromTop),
            rightOutline.widthAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func configureNoteLetters() {
        let topInset: CGFloat = -13
        let leftRightInset: CGFloat = 10
        let textViewWidth: CGFloat = 28
        let textViewHeight: CGFloat = 42
        
        let firstNoteIndex = (noteFingering.notes.count == 2) ? 1 : 0
        
        switch noteFingering.notes[firstNoteIndex].letter {
        case .a:
            leftTextView.text = "A"
        case .b:
            leftTextView.text = "B"
        case .c:
            leftTextView.text = "C"
        case .d:
            leftTextView.text = "D"
        case .e:
            leftTextView.text = "E"
        case .f:
            leftTextView.text = "F"
        case .g:
            leftTextView.text = "G"
        }
        
        contentView.addSubview(leftTextView)
        
        NSLayoutConstraint.activate([
            leftTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
            leftTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leftRightInset - 5),
            leftTextView.heightAnchor.constraint(equalToConstant: textViewHeight),
            leftTextView.widthAnchor.constraint(equalToConstant: textViewWidth)
        ])
        
        if noteFingering.notes.count == 2 {
            rightTextView.isHidden = false
            letterFlatView.isHidden = false
            letterSharpView.isHidden = false
            
            switch noteFingering.notes[0].letter {
            case .a:
                rightTextView.text = "A"
            case .b:
                rightTextView.text = "B"
            case .c:
                rightTextView.text = "C"
            case .d:
                rightTextView.text = "D"
            case .e:
                rightTextView.text = "E"
            case .f:
                rightTextView.text = "F"
            case .g:
                rightTextView.text = "G"
            }
            
            contentView.addSubview(rightTextView)
            contentView.addSubview(letterFlatView)
            contentView.addSubview(letterSharpView)
            
            NSLayoutConstraint.activate([
                rightTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
                rightTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -leftRightInset),
                rightTextView.heightAnchor.constraint(equalToConstant: textViewHeight),
                rightTextView.widthAnchor.constraint(equalToConstant: textViewWidth),
                
                letterSharpView.leadingAnchor.constraint(equalTo: rightTextView.trailingAnchor, constant: -5),
                letterSharpView.centerYAnchor.constraint(equalTo: rightTextView.centerYAnchor, constant: 7),
                
                letterFlatView.trailingAnchor.constraint(equalTo: leftTextView.leadingAnchor, constant: 8),
                letterFlatView.centerYAnchor.constraint(equalTo: leftTextView.centerYAnchor, constant: 8)
            ])
        } else {
            rightTextView.isHidden = true
            letterFlatView.isHidden = true
            letterSharpView.isHidden = true
        }
    }
    
    private func configureExtraNoteLines() {
        for line in currentExtraLines {
            line.removeFromSuperview()
        }
        currentExtraLines.removeAll()
        
        let firstNote = noteFingering.notes[0]
        let secondNote = (noteFingering.notes.count == 2) ? noteFingering.notes[1] : noteFingering.notes[0]
        
        let needsThickLine = firstNote.type == .flat || firstNote.type == .sharp
        
        switch firstNote.position {
        case .bottom8thLine, .bottom9thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop + 10 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .bottom7thLine, .bottom8thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop + 9 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .bottom6thLine, .bottom7thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop + 8 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .bottom5thLine, .bottom6thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop + 7 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .bottom4thLine, .bottom5thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop + 6 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .bottom3rdLine, .bottom4thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop + 5 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .bottom2ndLine, .bottom3rdSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop + 4 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .bottom1stLine, .bottom2ndSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop + 3 * spaceBetweenStaffLines, thickLine: needsThickLine)
        default:
            break
        }
        
        switch secondNote.position {
        case .top8thLine:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop - 10 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .top7thLine, .top8thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop - 9 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .top6thLine, .top7thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop - 8 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .top5thLine, .top6thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop - 7 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .top4thLine, .top5thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop - 6 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .top3rdLine, .top4thSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop - 5 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .top2ndLine, .top3rdSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop - 4 * spaceBetweenStaffLines, thickLine: needsThickLine)
            fallthrough
        case .top1stLine, .top2ndSpace:
            addExtraStaffLine(topInset: centerOfStaffInsetFromTop - 3 * spaceBetweenStaffLines, thickLine: needsThickLine)
        default:
            break
        }
    }
    
    private func addExtraStaffLine(topInset: CGFloat, thickLine: Bool) {
        let lineWidth: CGFloat = 30 * spaceBetweenStaffLines / 10
        
        let extraLineImageView = thickLine ?
            UIImageView(image: UIImage.drawStaffLine(color: .notebookBlack,size: CGSize(width: lineWidth, height: 1),rounded: true).withTintColor(.notebookBlack)) :
            UIImageView(image: UIImage.drawStaffLine(color: .notebookBlack, size: CGSize(width: lineWidth / 2, height: 1), rounded: true).withTintColor(.notebookBlack))
        extraLineImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(extraLineImageView)
        currentExtraLines.append(extraLineImageView)
        
        NSLayoutConstraint.activate([
            extraLineImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            extraLineImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset)
        ])
    }
    
    private func configureNotes() {
        for note in currentWholeNotes {
            note.removeFromSuperview()
        }
        
        currentWholeNotes.removeAll()
        
        let noteWidth: CGFloat = 14 * spaceBetweenStaffLines / 10
        let noteHeight: CGFloat = 10 * spaceBetweenStaffLines / 10
        
        let firstNote = noteFingering.notes[0]
        let firstNoteTopInset = calculateNoteTopInset(note: firstNote, noteHeight: noteHeight)
        
        if noteFingering.notes.count == 2 {
            let secondNoteTopInset = calculateNoteTopInset(note: noteFingering.notes[1], noteHeight: noteHeight)
            
            let note1 = createWholeNote()
            contentView.addSubview(note1)
            currentWholeNotes.append(note1)
            
            let note2 = createWholeNote()
            contentView.addSubview(note2)
            currentWholeNotes.append(note2)
            
            let sharpView = UIImageView(image: UIImage(named: UIImage.MusicSymbols.sharp)!.withTintColor(.notebookBlack))
            sharpView.transform = CGAffineTransform(scaleX: spaceBetweenStaffLines / 10 - 0.5, y: spaceBetweenStaffLines / 10 - 0.5)
            sharpView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(sharpView)
            currentWholeNotes.append(sharpView)
            
            let flatView = UIImageView(image: UIImage(named: UIImage.MusicSymbols.flat)!.withTintColor(.notebookBlack))
            flatView.transform = CGAffineTransform(scaleX: spaceBetweenStaffLines / 10 - 0.5, y: spaceBetweenStaffLines / 10 - 0.5)
            flatView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(flatView)
            currentWholeNotes.append(flatView)
            
            NSLayoutConstraint.activate([
                note1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: noteWidth / 2),
                note1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: firstNoteTopInset),
                
                note2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -noteWidth / 2),
                note2.topAnchor.constraint(equalTo: contentView.topAnchor, constant: secondNoteTopInset),
                
                sharpView.leadingAnchor.constraint(equalTo: note1.trailingAnchor, constant: -4),
                sharpView.centerYAnchor.constraint(equalTo: note1.centerYAnchor),
                
                flatView.trailingAnchor.constraint(equalTo: note2.leadingAnchor, constant: 2),
                flatView.centerYAnchor.constraint(equalTo: note2.centerYAnchor, constant: -6)
            ])
        } else {
            let note = createWholeNote()
            
            contentView.addSubview(note)
            currentWholeNotes.append(note)
            
            NSLayoutConstraint.activate([
                note.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                note.topAnchor.constraint(equalTo: contentView.topAnchor, constant: firstNoteTopInset),
            ])
        }
    }
    
    private func calculateNoteTopInset(note: Note, noteHeight: CGFloat) -> CGFloat {
        let noteTopInset: CGFloat = centerOfStaffInsetFromTop - noteHeight / 2 + 0.5
        
        switch note.position {
        case .bottom9thSpace:
            return noteTopInset + spaceBetweenStaffLines * 10.5
        case .bottom8thLine:
            return noteTopInset + spaceBetweenStaffLines * 10
        case .bottom8thSpace:
            return noteTopInset + spaceBetweenStaffLines * 9.5
        case .bottom7thLine:
            return noteTopInset + spaceBetweenStaffLines * 9
        case .bottom7thSpace:
            return noteTopInset + spaceBetweenStaffLines * 8.5
        case .bottom6thLine:
            return noteTopInset + spaceBetweenStaffLines * 8
        case .bottom6thSpace:
            return noteTopInset + spaceBetweenStaffLines * 7.5
        case .bottom5thLine:
            return noteTopInset + spaceBetweenStaffLines * 7
        case .bottom5thSpace:
            return noteTopInset + spaceBetweenStaffLines * 6.5
        case .bottom4thLine:
            return noteTopInset + spaceBetweenStaffLines * 6
        case .bottom4thSpace:
            return noteTopInset + spaceBetweenStaffLines * 5.5
        case .bottom3rdLine:
            return noteTopInset + spaceBetweenStaffLines * 5
        case .bottom3rdSpace:
            return noteTopInset + spaceBetweenStaffLines * 4.5
        case .bottom2ndLine:
            return noteTopInset + spaceBetweenStaffLines * 4
        case .bottom2ndSpace:
            return noteTopInset + spaceBetweenStaffLines * 3.5
        case .bottom1stLine:
            return noteTopInset + spaceBetweenStaffLines * 3
        case .bottom1stSpace:
            return noteTopInset + spaceBetweenStaffLines * 2.5
        case .middle1stLine:
            return noteTopInset + spaceBetweenStaffLines * 2
        case .middle1stSpace:
            return noteTopInset + spaceBetweenStaffLines * 1.5
        case .middle2ndLine:
            return noteTopInset + spaceBetweenStaffLines
        case .middle2ndSpace:
            return noteTopInset + spaceBetweenStaffLines * 0.5
        case .middle3rdLine:
            return noteTopInset
        case .middle3rdSpace:
            return noteTopInset - spaceBetweenStaffLines * 0.5
        case .middle4thLine:
            return noteTopInset - spaceBetweenStaffLines
        case .middle4thSpace:
            return noteTopInset - spaceBetweenStaffLines * 1.5
        case .middle5thLine:
            return noteTopInset - spaceBetweenStaffLines * 2
        case .top1stSpace:
            return noteTopInset - spaceBetweenStaffLines * 2.5
        case .top1stLine:
            return noteTopInset - spaceBetweenStaffLines * 3
        case .top2ndSpace:
            return noteTopInset - spaceBetweenStaffLines * 3.5
        case .top2ndLine:
            return noteTopInset - spaceBetweenStaffLines * 4
        case .top3rdSpace:
            return noteTopInset - spaceBetweenStaffLines * 4.5
        case .top3rdLine:
            return noteTopInset - spaceBetweenStaffLines * 5
        case .top4thSpace:
            return noteTopInset - spaceBetweenStaffLines * 5.5
        case .top4thLine:
            return noteTopInset - spaceBetweenStaffLines * 6
        case .top5thSpace:
            return noteTopInset - spaceBetweenStaffLines * 6.5
        case .top5thLine:
            return noteTopInset - spaceBetweenStaffLines * 7
        case .top6thSpace:
            return noteTopInset - spaceBetweenStaffLines * 7.5
        case .top6thLine:
            return noteTopInset - spaceBetweenStaffLines * 8
        case .top7thSpace:
            return noteTopInset - spaceBetweenStaffLines * 8.5
        case .top7thLine:
            return noteTopInset - spaceBetweenStaffLines * 9
        case .top8thSpace:
            return noteTopInset - spaceBetweenStaffLines * 9.5
        case .top8thLine:
            return noteTopInset - spaceBetweenStaffLines * 10
        }
    }
    
    private func createWholeNote() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: UIImage.MusicSymbols.cellWholeNote)!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: spaceBetweenStaffLines / 10, y: spaceBetweenStaffLines / 10)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    private func configureFingering() {
        for fingering in currentFingerings {
            fingering.removeFromSuperview()
        }
        
        currentFingerings.removeAll()
        
        optionalLabel.removeFromSuperview()
        contentView.addSubview(optionalLabel)
        
        NSLayoutConstraint.activate([
            optionalLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            optionalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        if noteFingering.fingerings.isEmpty {
            optionalLabel.isHidden = false
        } else {
            optionalLabel.isHidden = true
            
            for (index, fingering) in noteFingering.shorten(to: UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit)).reversed().enumerated() {
                let fingeringView: FingeringView
                let bottomSpacing: CGFloat
                
                switch chartsController.currentChart.instrument.type {
                case .cFlute:
                    fingeringView = FluteFingeringView(fingering: fingering, ratio: 0.4)
                    bottomSpacing = -17
                case .bbSopranoClarinet:
                    fingeringView = ClarinetFingeringView(fingering: fingering, ratio: 0.35)
                    bottomSpacing = -27
                case .ebAltoSaxophone, .bbTenorSaxophone:
                    fingeringView = SaxophoneFingeringView(fingering: fingering, ratio: 0.38)
                    bottomSpacing = -21
                case .ebBaritoneSaxophone:
                    fingeringView = BaritoneSaxophoneFingeringView(fingering: fingering, ratio: 0.35)
                    bottomSpacing = -21
                case .bbTrumpet, .fMellophone, .fSingleFrenchHorn, .bbBaritoneHorn, .threeValveBBbTuba, .threeValveEbTuba:
                    fingeringView = ThreeValveFingeringView(fingering: fingering, ratio: 0.5)
                    bottomSpacing = -15
                case .fBbDoubleFrenchHorn:
                    fingeringView = BbTriggerThreeValveFingeringView(fingering: fingering, ratio: 0.5)
                    bottomSpacing = -15
                case .fourValveBbEuphoniumCompensating, .fourValveBbEuphoniumNonCompensating:
                    fingeringView = FourValveFingeringView(fingering: fingering, ratio: 0.5)
                    bottomSpacing = -15
                case .bbTenorTrombone:
                    fingeringView = PositionFingeringView(fingering: fingering, ratio: 0.75)
                    bottomSpacing = -15
                case .fTriggerBbTenorTrombone:
                    fingeringView = FTriggerPositionFingeringView(fingering: fingering, ratio: 0.75)
                    bottomSpacing = -18
                }
                
                let bottomInset = bottomSpacing - CGFloat(chartsController.currentChart.instrument.chartFingeringHeight * index)
                
                fingeringView.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(fingeringView)
                
                fingeringView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                fingeringView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bottomInset).isActive = true
                
                currentFingerings.append(fingeringView)
            }
        }
    }
}

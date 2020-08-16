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
    static let cellHeight: CGFloat = 240
    
    private let centerOfStaffInsetFromTop: CGFloat = 90
    private let spaceBetweenStaffLines: CGFloat = 10
    
    private var cellWidth: CGFloat!
    private var noteFingering: NoteFingering!
    
    private var currentExtraLines = [UIImageView]()
    private var currentWholeNotes = [UIImageView]()
    private var currentFingerings = [UIImageView]()
    
    private lazy var optionalLabel: UILabel = {
        var lab = UILabel()
        lab.font = UIFont.preferredFont(forTextStyle: .title3)
        lab.textAlignment = .center
        lab.textColor = UIColor(named: "Black")
        lab.isHidden = true
        lab.text = "N/A"
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        return lab
    }()
    
    private lazy var leftTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 34)
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    private lazy var rightTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 34)
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    private lazy var letterFlatView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "CellFlat")!.withTintColor(UIColor(named: "Black")!))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var letterSharpView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "CellSharp")!.withTintColor(UIColor(named: "Black")!))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoteChartCell {
    func configureCell(collectionViewWidth: CGFloat, noteFingering: NoteFingering) {
        self.cellWidth = collectionViewWidth / 3
        self.noteFingering = noteFingering
        
        configureStaff()
        configureOutline()
        configureNoteLetters()
        configureExtraNoteLines()
        configureNotes()
        configureFingering()
    }
    
    private func configureStaff() {
        for i in -2...2 {
            addStaffLine(topInset: centerOfStaffInsetFromTop + spaceBetweenStaffLines * CGFloat(i))
        }
        
        let trebleClefImageView = UIImageView(image: UIImage(named: "CellTrebleClef")!.withTintColor(UIColor(named: "Black")!))
        trebleClefImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trebleClefImageView)
        
        NSLayoutConstraint.activate([
            trebleClefImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trebleClefImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: centerOfStaffInsetFromTop - (3 * spaceBetweenStaffLines + 5))
        ])
    }
    
    private func addStaffLine(topInset: CGFloat) {
        let staffImageView = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: cellWidth, height: 1), rounded: false).withTintColor(UIColor(named: "Black")!))
        staffImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(staffImageView)
        
        NSLayoutConstraint.activate([
            staffImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
            staffImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    private func configureOutline() {
        let insetFromTop = centerOfStaffInsetFromTop - 2 * spaceBetweenStaffLines
        
        let leftOutline = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 0.5, height: NoteChartCell.cellHeight - insetFromTop), rounded: false).withTintColor(UIColor(named: "Black")!))
        leftOutline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(leftOutline)
        
        let bottomOutline = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: cellWidth, height: 1), rounded: false).withTintColor(UIColor(named: "Black")!))
        bottomOutline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bottomOutline)
        
        let rightOutline = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 0.5, height: NoteChartCell.cellHeight - insetFromTop), rounded: false).withTintColor(UIColor(named: "Black")!))
        rightOutline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(rightOutline)
        
        NSLayoutConstraint.activate([
            leftOutline.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -0.1),
            leftOutline.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insetFromTop),
            leftOutline.heightAnchor.constraint(equalToConstant: NoteChartCell.cellHeight - insetFromTop),
            leftOutline.widthAnchor.constraint(equalToConstant: 0.5),
            
            bottomOutline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomOutline.heightAnchor.constraint(equalToConstant: 1),
            bottomOutline.widthAnchor.constraint(equalToConstant: cellWidth),
            
            rightOutline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rightOutline.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insetFromTop),
            rightOutline.heightAnchor.constraint(equalToConstant: NoteChartCell.cellHeight - insetFromTop),
            rightOutline.widthAnchor.constraint(equalToConstant: 0.5),
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
                
                letterSharpView.leadingAnchor.constraint(equalTo: rightTextView.trailingAnchor, constant: 2),
                letterSharpView.centerYAnchor.constraint(equalTo: rightTextView.centerYAnchor, constant: 7),
                
                letterFlatView.trailingAnchor.constraint(equalTo: leftTextView.leadingAnchor, constant: 3),
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
        case .bottom8thLine:
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
        case .top6thLine:
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
        let lineWidth: CGFloat = 30
        
        let extraLineImageView = thickLine ? UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: lineWidth, height: 1), rounded: true).withTintColor(UIColor(named: "Black")!)) : UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: lineWidth / 2, height: 1), rounded: true).withTintColor(UIColor(named: "Black")!))
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
        
        let noteWidth: CGFloat = 14
        let noteHeight: CGFloat = 10
        
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
            
            let sharpView = UIImageView(image: UIImage(named: "CellSharp")!.withTintColor(UIColor(named: "Black")!))
            sharpView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(sharpView)
            currentWholeNotes.append(sharpView)
            
            let flatView = UIImageView(image: UIImage(named: "CellFlat")!.withTintColor(UIColor(named: "Black")!))
            flatView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(flatView)
            currentWholeNotes.append(flatView)
            
            NSLayoutConstraint.activate([
                note1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: noteWidth / 2),
                note1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: firstNoteTopInset),
                note1.widthAnchor.constraint(equalToConstant: noteWidth),
                note1.heightAnchor.constraint(equalToConstant: noteHeight),
                
                note2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -noteWidth / 2),
                note2.topAnchor.constraint(equalTo: contentView.topAnchor, constant: secondNoteTopInset),
                note2.widthAnchor.constraint(equalToConstant: noteWidth),
                note2.heightAnchor.constraint(equalToConstant: noteHeight),
                
                sharpView.leadingAnchor.constraint(equalTo: note1.trailingAnchor, constant: 1.5),
                sharpView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: firstNoteTopInset - 6),
                
                flatView.trailingAnchor.constraint(equalTo: note2.leadingAnchor, constant: -2),
                flatView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: secondNoteTopInset - 10),
            ])
        } else {
            let note = createWholeNote()
            
            contentView.addSubview(note)
            currentWholeNotes.append(note)
            
            NSLayoutConstraint.activate([
                note.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                note.topAnchor.constraint(equalTo: contentView.topAnchor, constant: firstNoteTopInset),
                note.widthAnchor.constraint(equalToConstant: noteWidth),
                note.heightAnchor.constraint(equalToConstant: noteHeight),
            ])
        }
    }
    
    private func calculateNoteTopInset(note: Note, noteHeight: CGFloat) -> CGFloat {
        let noteTopInset: CGFloat = centerOfStaffInsetFromTop - noteHeight / 2 + 0.5
        
        switch note.position {
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
        }
    }
    
    private func createWholeNote() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "CellWholeNote")!.withTintColor(UIColor(named: "Black")!))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    private func configureFingering() {
        for fingering in currentFingerings {
            fingering.removeFromSuperview()
        }
        
        currentFingerings.removeAll()
        
        contentView.addSubview(optionalLabel)
        
        NSLayoutConstraint.activate([
            optionalLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            optionalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -13)
        ])
        
        if noteFingering.fingerings[0].keys.count == 0 {
            optionalLabel.isHidden = false
        } else {
            optionalLabel.isHidden = true
            
            if noteFingering.fingerings.count == 2 {
                let fingeringView: UIImageView
                let fingeringView2: UIImageView
                
                switch ChartsController.shared.currentChart.instrument.type {
                case .trumpet:
                    fingeringView = createTrumpetNoteFingering(with: noteFingering.fingerings[0].keys)
                    fingeringView2 = createTrumpetNoteFingering(with: noteFingering.fingerings[1].keys)
                    
                    contentView.addSubview(fingeringView)
                    currentFingerings.append(fingeringView)
                    
                    contentView.addSubview(fingeringView2)
                    currentFingerings.append(fingeringView2)
                    
                    NSLayoutConstraint.activate([
                        fingeringView2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5),
                        fingeringView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                        
                        fingeringView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5),
                        fingeringView.bottomAnchor.constraint(equalTo: fingeringView2.topAnchor, constant: -2)
                    ])
                case .euphoniumTCNC, .euphoniumTCC:
                    fingeringView = createEuphoniumNoteFingering(with: noteFingering.fingerings[0].keys)
                    fingeringView2 = createEuphoniumNoteFingering(with: noteFingering.fingerings[1].keys)
                    
                    contentView.addSubview(fingeringView)
                    currentFingerings.append(fingeringView)
                    
                    contentView.addSubview(fingeringView2)
                    currentFingerings.append(fingeringView2)
                    
                    NSLayoutConstraint.activate([
                        fingeringView2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 2),
                        fingeringView2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                        
                        fingeringView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 2),
                        fingeringView.bottomAnchor.constraint(equalTo: fingeringView2.topAnchor, constant: -2)
                    ])
                }
            } else {
                let fingeringView: UIImageView
                
                switch ChartsController.shared.currentChart.instrument.type {
                case .trumpet:
                    fingeringView = createTrumpetNoteFingering(with: noteFingering.fingerings[0].keys)
                    
                    contentView.addSubview(fingeringView)
                    currentFingerings.append(fingeringView)
                    
                    NSLayoutConstraint.activate([
                        fingeringView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5),
                        fingeringView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
                    ])
                case .euphoniumTCNC, .euphoniumTCC:
                    fingeringView = createEuphoniumNoteFingering(with: noteFingering.fingerings[0].keys)
                    
                    contentView.addSubview(fingeringView)
                    currentFingerings.append(fingeringView)
                    
                    NSLayoutConstraint.activate([
                        fingeringView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 2),
                        fingeringView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
                    ])
                }
            }
        }
    }
    
    private func createTrumpetNoteFingering(with keys: [Bool]) -> UIImageView {
        let trumpetFingeringHeight: CGFloat = 20
        let trumpetFingeringGap: CGFloat = 30
        let trumpetViewWidth: CGFloat = trumpetFingeringGap * 3
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: trumpetViewWidth, height: trumpetFingeringHeight))
        
        let img = renderer.image { ctx in
            for (index, key) in keys.enumerated() {
                let keyImage = UIImage(named: (key ? "RoundFingeringFull\(index + 1)" : "RoundFingeringEmpty\(index + 1)"))
                keyImage?.draw(in: CGRect(origin: CGPoint(x: CGFloat(index) * trumpetFingeringGap, y: 0), size: CGSize(width: trumpetFingeringHeight, height: trumpetFingeringHeight)))
            }
        }
        
        let imageView = UIImageView()
        imageView.image = img.withTintColor(UIColor(named: "Black")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    private func createEuphoniumNoteFingering(with keys: [Bool]) -> UIImageView {
        let euphoniumFingeringHeight: CGFloat = 20
        let euphoniumFingeringGap: CGFloat = 21.25
        let euphoniumViewWidth: CGFloat = 30 * 3
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: euphoniumViewWidth, height: euphoniumFingeringHeight))
        
        let img = renderer.image { ctx in
            for (index, key) in keys.enumerated() {
                let keyImage = UIImage(named: (key ? "RoundFingeringFull\(index + 1)" : "RoundFingeringEmpty\(index + 1)"))
                keyImage?.draw(in: CGRect(origin: CGPoint(x: CGFloat(index) * euphoniumFingeringGap, y: 0), size: CGSize(width: euphoniumFingeringHeight, height: euphoniumFingeringHeight)))
            }
        }
        
        let imageView = UIImageView()
        imageView.image = img.withTintColor(UIColor(named: "Black")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
}

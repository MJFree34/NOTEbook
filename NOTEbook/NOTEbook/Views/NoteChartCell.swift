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
    static let cellHeight: CGFloat = 190
    
    private var cellWidth: CGFloat!
    private var noteFingering: NoteFingering!
    
    var currentExtraLines = [UIImageView]()
    var currentWholeNotes = [UIImageView]()
    var currentFingerings = [UIImageView]()
    
    lazy var leftTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 34)
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var rightTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 34)
        textView.textAlignment = .center
        textView.backgroundColor = .clear
        textView.isUserInteractionEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var letterFlatView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "CellFlat"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var letterSharpView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "CellSharp"))
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
    
    func configureStaff() {
        // Adds staff
        let lineInsetFromTop: CGFloat = 0.2368421053 * NoteChartCell.cellHeight
        let lineInsetFromBottom: CGFloat = 0.5526315789 * NoteChartCell.cellHeight
        
        for i in 0..<5 {
            addStaffLine(topInset: lineInsetFromTop + 10 * CGFloat(i), bottomInset: lineInsetFromBottom - 1 + (10 * (4 - CGFloat(i))))
        }
        
        // Adds clef
        let trebleClefInsetFromTop: CGFloat = 0.1526315789 * NoteChartCell.cellHeight
        let trebleClefInsetFromBottom: CGFloat = 0.4649473684 * NoteChartCell.cellHeight
        
        let trebleClefImageView = UIImageView(image: UIImage(named: "CellTrebleClef"))
        trebleClefImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trebleClefImageView)
        
        NSLayoutConstraint.activate([
            trebleClefImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trebleClefImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: trebleClefInsetFromTop),
            trebleClefImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -trebleClefInsetFromBottom)
        ])
    }
    
    func addStaffLine(topInset: CGFloat, bottomInset: CGFloat) {
        let staffImageView = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: cellWidth, height: 1), rounded: false))
        staffImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(staffImageView)
        
        NSLayoutConstraint.activate([
            staffImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
            staffImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bottomInset),
            staffImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func configureOutline() {
        let insetFromTop: CGFloat = 0.2368421053 * NoteChartCell.cellHeight
        
        let leftOutline = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 0.5, height: NoteChartCell.cellHeight - insetFromTop), rounded: false))
        leftOutline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(leftOutline)
        
        let bottomOutline = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: cellWidth, height: 1), rounded: false))
        bottomOutline.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bottomOutline)
        
        let rightOutline = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 0.5, height: NoteChartCell.cellHeight - insetFromTop), rounded: false))
        
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
    
    func configureNoteLetters() {
        let topInset: CGFloat = -0.0736842105 * NoteChartCell.cellHeight
        let leftRightInset: CGFloat = 0.06 * cellWidth
        let textHeight: CGFloat = 0.2157894737 * NoteChartCell.cellHeight
        let textWidth: CGFloat = 0.28 * cellWidth
        
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
            leftTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: leftRightInset),
            leftTextView.heightAnchor.constraint(equalToConstant: textHeight),
            leftTextView.widthAnchor.constraint(equalToConstant: textWidth),
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
                rightTextView.heightAnchor.constraint(equalToConstant: textHeight),
                rightTextView.widthAnchor.constraint(equalToConstant: textWidth),
                
                letterSharpView.leadingAnchor.constraint(equalTo: rightTextView.trailingAnchor, constant: -2),
                letterSharpView.centerYAnchor.constraint(equalTo: rightTextView.centerYAnchor, constant: 7),
                
                letterFlatView.trailingAnchor.constraint(equalTo: leftTextView.leadingAnchor),
                letterFlatView.centerYAnchor.constraint(equalTo: leftTextView.centerYAnchor, constant: 8)
            ])
        } else {
            rightTextView.isHidden = true
            letterFlatView.isHidden = true
            letterSharpView.isHidden = true
        }
    }
    
    func configureExtraNoteLines() {
        for line in currentExtraLines {
            line.removeFromSuperview()
        }
        currentExtraLines.removeAll()

        var firstNote = noteFingering.notes[0]
        
        let ab5Fix = firstNote.octave == .five && firstNote.letter == .g && firstNote.type == .sharp

        if firstNote.extraLinesLocation != .none || ab5Fix {
            let noteIsTop = firstNote.extraLinesLocation == .top || ab5Fix
            let needsThickLine = firstNote.type == .flat || firstNote.type == .sharp
            let properNumberOfExtraLines = (firstNote.octave == .five && firstNote.letter == .g && firstNote.type == .sharp) ? noteFingering.notes[1].numberOfExtraLines : firstNote.numberOfExtraLines
            
            let lineInsetFromTop: CGFloat = 0.2368421053 * NoteChartCell.cellHeight + (noteIsTop ? -40 : 40)
            let lineInsetFromBottom: CGFloat = 0.5526315789 * NoteChartCell.cellHeight + (noteIsTop ? 40 : -40)
            
            for i in 1...properNumberOfExtraLines {
                addExtraStaffLine(topInset: lineInsetFromTop + 10 * CGFloat(i) * (noteIsTop ? -1 : 1) + (noteIsTop ? 40 : 0), bottomInset: lineInsetFromBottom - 1 + 10 * (4 - CGFloat(i) * (noteIsTop ? -1 : 1)) - (noteIsTop ? 40 : 0), thickLine: needsThickLine)
            }
        }
    }
    
    func addExtraStaffLine(topInset: CGFloat, bottomInset: CGFloat, thickLine: Bool) {
        let lineWidth: CGFloat = 0.25 * cellWidth
        
        let extraLineImageView = thickLine ? UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: lineWidth, height: 1), rounded: true)) : UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: lineWidth / 2, height: 1), rounded: true))
        extraLineImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(extraLineImageView)
        currentExtraLines.append(extraLineImageView)
        
        NSLayoutConstraint.activate([
            extraLineImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            extraLineImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
            extraLineImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -bottomInset),
        ])
    }
    
    func configureNotes() {
        for note in currentWholeNotes {
            note.removeFromSuperview()
        }
        
        currentWholeNotes.removeAll()
        
        let noteWidth: CGFloat = 14
        let noteHeight: CGFloat = 10
        
        let firstNote = noteFingering.notes[0]
        
        let topInset: CGFloat = 0.1526315789 * NoteChartCell.cellHeight - 19 + calculateNoteTopInset(note: firstNote)
        
        if noteFingering.notes.count == 2 {
            let topInset2: CGFloat = 0.1526315789 * NoteChartCell.cellHeight - 19 + calculateNoteTopInset(note: noteFingering.notes[1])
            
            let note1 = createWholeNote()
            contentView.addSubview(note1)
            currentWholeNotes.append(note1)
            
            let note2 = createWholeNote()
            contentView.addSubview(note2)
            currentWholeNotes.append(note2)
            
            let sharpView = UIImageView(image: UIImage(named: "CellSharp"))
            sharpView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(sharpView)
            currentWholeNotes.append(sharpView)
            
            let flatView = UIImageView(image: UIImage(named: "CellFlat"))
            flatView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(flatView)
            currentWholeNotes.append(flatView)
            
            NSLayoutConstraint.activate([
                note1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: noteWidth / 2),
                note1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
                note1.widthAnchor.constraint(equalToConstant: noteWidth),
                note1.heightAnchor.constraint(equalToConstant: noteHeight),
                
                note2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -noteWidth / 2),
                note2.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset2),
                note2.widthAnchor.constraint(equalToConstant: noteWidth),
                note2.heightAnchor.constraint(equalToConstant: noteHeight),
                
                sharpView.leadingAnchor.constraint(equalTo: note1.trailingAnchor, constant: 1.5),
                sharpView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset - 6),
                
                flatView.trailingAnchor.constraint(equalTo: note2.leadingAnchor, constant: -2),
                flatView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset2 - 10),
            ])
        } else {
            let note = createWholeNote()
            
            contentView.addSubview(note)
            currentWholeNotes.append(note)
            
            NSLayoutConstraint.activate([
                note.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                note.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
                note.widthAnchor.constraint(equalToConstant: noteWidth),
                note.heightAnchor.constraint(equalToConstant: noteHeight),
            ])
        }
    }
    
    func calculateNoteTopInset(note: Note) -> CGFloat {
        switch note.octave {
        case .three:
            switch note.letter {
            case .c:
                return 115
            case .d:
                return 110
            case .e:
                return 105
            case .f:
                return 100
            case .g:
                return 95
            case .a:
                return 90
            case .b:
                return 85
            }
        case .four:
            switch note.letter {
            case .c:
                return 80
            case .d:
                return 75
            case .e:
                return 70
            case .f:
                return 65
            case .g:
                return 60
            case .a:
                return 55
            case .b:
                return 50
            }
        case .five:
            switch note.letter {
            case .c:
                return 45
            case .d:
                return 40
            case .e:
                return 35
            case .f:
                return 30
            case .g:
                return 25
            case .a:
                return 20
            case .b:
                return 15
            }
        case .six:
            switch note.letter {
            case .c:
                return 10
            case .d:
                return 5
            case .e:
                return 0
            case .f:
                return -5
            case .g, .a, .b:
                break
            }
        case .zero, .one, .two, .seven:
            break
        }
        
        return 0
    }
    
    func createWholeNote() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "CellWholeNote"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
    
    func configureFingering() {
        for fingering in currentFingerings {
            fingering.removeFromSuperview()
        }
        
        currentFingerings.removeAll()
        
        let trumpetViewWidth: CGFloat = 0.6875 * cellWidth
        let trumpetViewHeight: CGFloat = 0.109 * NoteChartCell.cellHeight
        
        if noteFingering.fingerings.count == 2 {
            let topInset: CGFloat = 0.7244736842 * NoteChartCell.cellHeight
            
            let fingeringView = createTrumpetNoteFingering(with: noteFingering.fingerings[0].keys)
            contentView.addSubview(fingeringView)
            currentFingerings.append(fingeringView)
            
            NSLayoutConstraint.activate([
                fingeringView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                fingeringView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
                fingeringView.heightAnchor.constraint(equalToConstant: trumpetViewHeight),
                fingeringView.widthAnchor.constraint(equalToConstant: trumpetViewWidth),
            ])
            
            let fingeringView2 = createTrumpetNoteFingering(with: noteFingering.fingerings[1].keys)
            contentView.addSubview(fingeringView2)
            currentFingerings.append(fingeringView2)
            
            NSLayoutConstraint.activate([
                fingeringView2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                fingeringView2.topAnchor.constraint(equalTo: fingeringView.bottomAnchor, constant: 2),
                fingeringView2.heightAnchor.constraint(equalToConstant: trumpetViewHeight),
                fingeringView2.widthAnchor.constraint(equalToConstant: trumpetViewWidth),
            ])
        } else {
            let topInset: CGFloat = 0.785 * NoteChartCell.cellHeight
            
            let fingeringView = createTrumpetNoteFingering(with: noteFingering.fingerings[0].keys)
            contentView.addSubview(fingeringView)
            currentFingerings.append(fingeringView)
            
            NSLayoutConstraint.activate([
                fingeringView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                fingeringView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topInset),
                fingeringView.heightAnchor.constraint(equalToConstant: trumpetViewHeight),
                fingeringView.widthAnchor.constraint(equalToConstant: trumpetViewWidth),
            ])
        }
    }
    
    func createTrumpetNoteFingering(with keys: [Bool]) -> UIImageView {
        let trumpetViewWidth: CGFloat = 0.6875 * cellWidth
        let trumpetViewHeight: CGFloat = 0.109 * NoteChartCell.cellHeight
        let fingeringPositionMultiplier: CGFloat = 0.3823863636 * trumpetViewWidth
        let trumpetFingeringWidth: CGFloat = 0.161796875 * cellWidth
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: trumpetViewWidth, height: trumpetViewHeight))
        
        let img = renderer.image { ctx in
            for (index, key) in keys.enumerated() {
                let keyImage = UIImage(named: (key ? "CellTrumpetFingeringFull" : "CellTrumpetFingeringEmpty"))
                keyImage?.draw(in: CGRect(origin: CGPoint(x: CGFloat(index) * fingeringPositionMultiplier, y: 0), size: CGSize(width: trumpetFingeringWidth, height: trumpetFingeringWidth)))
            }
        }
        
        let imageView = UIImageView()
        imageView.image = img
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }
}

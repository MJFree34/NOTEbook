//
//  LetterArrowView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/9/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class LetterArrowViewController: UIViewController {
    static var fingeringHeight: CGFloat = 85
    
    var letterLabel: UILabel!
    var fingeringScrollingView: FingeringScrollingView!
    
    var currentNoteFingering: NoteFingering!
    var currentNoteType: NoteType = .natural
    
    var fingeringScrollingViewWidthConstraint: NSLayoutConstraint!
    
    lazy var rightArrow = ArrowImageView(left: false)
    lazy var leftArrow = ArrowImageView(left: true)
    
    lazy var arrowFlat = AccidentalImageView(noteType: .flat)
    lazy var arrowSharp = AccidentalImageView(noteType: .sharp)
    lazy var leftArrowNatural = AccidentalImageView(noteType: .natural)
    lazy var rightArrowNatural = AccidentalImageView(noteType: .natural)
    
    private var chartsController = ChartsController.shared
    
    lazy var noteLetterView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 85, height: 100))
        view.addLightMediumAquaGradient()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var letterFlat: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 18.25, height: 60))
        view.addLightMediumAquaGradient()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var letterSharp: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 26.87, height: 68))
        view.addLightMediumAquaGradient()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        configureNoteLetter()
        configureSwipeArrows()
        configureFingeringScrollingView()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        noteLetterView.addLightMediumAquaGradient()
        letterFlat.addLightMediumAquaGradient()
        letterSharp.addLightMediumAquaGradient()
    }
    
    private func configureNoteLetter() {
        addGradientLabel()
        view.addSubview(noteLetterView)
        
        letterFlat.isHidden = true
        addGradientFlat()
        view.addSubview(letterFlat)
        
        letterSharp.isHidden = true
        addGradientSharp()
        view.addSubview(letterSharp)
        
        NSLayoutConstraint.activate([
            noteLetterView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            noteLetterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noteLetterView.heightAnchor.constraint(equalToConstant: 100),
            noteLetterView.widthAnchor.constraint(equalToConstant: 86),
            
            letterFlat.centerYAnchor.constraint(equalTo: noteLetterView.centerYAnchor),
            letterFlat.leadingAnchor.constraint(equalTo: noteLetterView.trailingAnchor),
            letterFlat.heightAnchor.constraint(equalToConstant: 60),
            letterFlat.widthAnchor.constraint(equalToConstant: 18.25),
            
            letterSharp.centerYAnchor.constraint(equalTo: noteLetterView.centerYAnchor),
            letterSharp.leadingAnchor.constraint(equalTo: noteLetterView.trailingAnchor),
            letterSharp.heightAnchor.constraint(equalToConstant: 68),
            letterSharp.widthAnchor.constraint(equalToConstant: 26.87)
        ])
    }
    
    private func addGradientLabel() {
        letterLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 85, height: 100))
        letterLabel.text = chartsController.currentChart.centerNote!.capitalizedLetter()
        letterLabel.font = UIFont.noteFont
        letterLabel.textAlignment = .center
        letterLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLetterView.addSubview(letterLabel)

        noteLetterView.mask = letterLabel
    }
    
    private func addGradientFlat() {
        let flatImageView = AccidentalImageView(noteType: .flat)
        letterFlat.addSubview(flatImageView)

        letterFlat.mask = flatImageView
    }
    
    private func addGradientSharp() {
        let sharpImageView = AccidentalImageView(noteType: .sharp)
        letterSharp.addSubview(sharpImageView)

        letterSharp.mask = sharpImageView
    }
    
    private func configureSwipeArrows() {
        view.addSubview(rightArrow)
        view.addSubview(rightArrowNatural)
        view.addSubview(arrowSharp)
        view.addSubview(leftArrow)
        view.addSubview(leftArrowNatural)
        view.addSubview(arrowFlat)
        
        rightArrowNatural.alpha = 0
        leftArrowNatural.alpha = 0
        
        NSLayoutConstraint.activate([
            rightArrow.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            rightArrow.centerYAnchor.constraint(equalTo: noteLetterView.centerYAnchor, constant: -60),
            
            rightArrowNatural.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -5),
            rightArrowNatural.centerYAnchor.constraint(equalTo: rightArrow.centerYAnchor),
            
            arrowSharp.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -5),
            arrowSharp.centerYAnchor.constraint(equalTo: rightArrow.centerYAnchor),
            
            leftArrow.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leftArrow.centerYAnchor.constraint(equalTo: rightArrow.centerYAnchor),
            
            leftArrowNatural.leadingAnchor.constraint(equalTo: leftArrow.trailingAnchor, constant: 5),
            leftArrowNatural.centerYAnchor.constraint(equalTo: leftArrow.centerYAnchor),
            
            arrowFlat.leadingAnchor.constraint(equalTo: leftArrow.trailingAnchor, constant: 5),
            arrowFlat.centerYAnchor.constraint(equalTo: leftArrow.centerYAnchor)
        ])
    }
    
    private func configureFingeringScrollingView() {
        fingeringScrollingView = FingeringScrollingView()
        fingeringScrollingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fingeringScrollingView)
        
        NSLayoutConstraint.activate([
            fingeringScrollingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fingeringScrollingView.bottomAnchor.constraint(equalTo: noteLetterView.topAnchor, constant: -40),
            fingeringScrollingView.heightAnchor.constraint(equalToConstant: LetterArrowViewController.fingeringHeight)
        ])
        
        fingeringScrollingViewWidthConstraint = fingeringScrollingView.widthAnchor.constraint(equalToConstant: CGFloat(chartsController.currentChart.instrument.fingeringWidth))
        fingeringScrollingViewWidthConstraint.isActive = true
        
        fingeringScrollingView.fingerings = currentNoteFingering.shorten(to: UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit))
    }
    
    func showOrHideLetterAccidentals() {
        if currentNoteType == .flat {
            if (currentNoteFingering.notes[0].letter == .b && currentNoteFingering.notes[0].type == .natural) || (currentNoteFingering.notes[0].letter == .e && currentNoteFingering.notes[0].type == .natural) {
                letterFlat.isHidden = true
            } else {
                letterFlat.isHidden = false
            }
        } else if currentNoteType == .sharp {
            if (currentNoteFingering.notes[0].letter == .f && currentNoteFingering.notes[0].type == .natural) || (currentNoteFingering.notes[0].letter == .c && currentNoteFingering.notes[0].type == .natural) {
                letterSharp.isHidden = true
            } else {
                letterSharp.isHidden = false
            }
        } else {
            letterFlat.isHidden = true
            letterSharp.isHidden = true
        }
    }
}

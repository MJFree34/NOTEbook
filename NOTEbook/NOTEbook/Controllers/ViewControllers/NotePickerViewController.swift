//
//  ViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NotePickerViewController: UIViewController {
    var chartsController = ChartsController.shared
    
    var currentNoteType: NoteType = .natural
    static let spaceBetweenStaffLines: CGFloat = 24
    
    var letterLabel: UILabel!
    var fingeringPageViewController: FingeringPageViewController!
    var picker: NotePicker!
    
    var currentNoteFingering: NoteFingering!
    
    lazy var settingsBarButton: UIBarButtonItem = {
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "gear", withConfiguration: imageConfiguration)!
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsButtonTapped))
        
        return button
    }()
    
    lazy var gridButton: UIButton = {
        let image = UIImage(named: "GridButton")!
        let pressedImage = UIImage(named: "PressedGridButton")!
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.setImage(pressedImage, for: .highlighted)
        button.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var instrumentsBarButton: UIBarButtonItem = {
        let image = UIImage(named: "InstrumentsButton")!
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(instrumentsButtonTapped))
        
        return button
    }()
    
    lazy var rightArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "SwipeArrow")!.withTintColor(UIColor(named: "Black")!))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var leftArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "SwipeArrow")!.withTintColor(UIColor(named: "Black")!))
        imageView.transform = CGAffineTransform(rotationAngle: .pi)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrowFlat: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Flat")!.withTintColor(UIColor(named: "Black")!))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrowSharp: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Sharp")!.withTintColor(UIColor(named: "Black")!))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var leftArrowNatural: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Natural")!.withTintColor(UIColor(named: "Black")!))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var rightArrowNatural: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Natural")!.withTintColor(UIColor(named: "Black")!))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
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
    
    lazy var trebleClefImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TrebleClef")!.withTintColor(UIColor(named: "Black")!))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addBackgroundGradient()
        view.backgroundColor = UIColor(named: "White")
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changeNoteType))
        swipeLeft.numberOfTouchesRequired = 1
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changeNoteType))
        swipeRight.numberOfTouchesRequired = 1
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        
        currentNoteFingering = chartsController.noteFingeringInCurrentChart(for: chartsController.currentChart.centerNote)
        
        configureNoteLetter()
        configureSwipeArrows()
        configureFingeringPageView()
        configureBottomStaff()
        configurePicker()
        
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationItem.titleView = gridButton
//        navigationItem.rightBarButtonItem = instrumentsBarButton
        
        if !UserDefaults.standard.bool(forKey: UserDefaults.Keys.tutorialHasShown) {
            UserDefaults.standard.setValue(true, forKey: UserDefaults.Keys.tutorialHasShown)
            navigationController?.present(TutorialViewController(), animated: true)
        }
    }
    
    func configureNoteLetter() {
        addGradientLabel()
        view.addSubview(noteLetterView)
        
        letterFlat.isHidden = true
        addGradientFlat()
        view.addSubview(letterFlat)
        
        letterSharp.isHidden = true
        addGradientSharp()
        view.addSubview(letterSharp)
        
        NSLayoutConstraint.activate([
            noteLetterView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -100),
            noteLetterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noteLetterView.heightAnchor.constraint(equalToConstant: 100),
            noteLetterView.widthAnchor.constraint(equalToConstant: 85),
            
            letterFlat.centerYAnchor.constraint(equalTo: noteLetterView.centerYAnchor),
            letterFlat.leadingAnchor.constraint(equalTo: noteLetterView.trailingAnchor),
            letterFlat.heightAnchor.constraint(equalToConstant: 60),
            letterFlat.widthAnchor.constraint(equalToConstant: 18.25),
            
            letterSharp.centerYAnchor.constraint(equalTo: noteLetterView.centerYAnchor),
            letterSharp.leadingAnchor.constraint(equalTo: noteLetterView.trailingAnchor),
            letterSharp.heightAnchor.constraint(equalToConstant: 68),
            letterSharp.widthAnchor.constraint(equalToConstant: 26.87),
        ])
    }
    
    func configureSwipeArrows() {
        view.addSubview(rightArrow)
        view.addSubview(rightArrowNatural)
        view.addSubview(arrowSharp)
        view.addSubview(leftArrow)
        view.addSubview(leftArrowNatural)
        view.addSubview(arrowFlat)
        
        rightArrowNatural.alpha = 0
        leftArrowNatural.alpha = 0
        
        NSLayoutConstraint.activate([
            rightArrow.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            rightArrow.centerYAnchor.constraint(equalTo: noteLetterView.centerYAnchor, constant: -60),
            
            rightArrowNatural.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -5),
            rightArrowNatural.centerYAnchor.constraint(equalTo: rightArrow.centerYAnchor),
            
            arrowSharp.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -5),
            arrowSharp.centerYAnchor.constraint(equalTo: rightArrow.centerYAnchor),
            
            leftArrow.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            leftArrow.centerYAnchor.constraint(equalTo: rightArrow.centerYAnchor),
            
            leftArrowNatural.leadingAnchor.constraint(equalTo: leftArrow.trailingAnchor, constant: 5),
            leftArrowNatural.centerYAnchor.constraint(equalTo: leftArrow.centerYAnchor),
            
            arrowFlat.leadingAnchor.constraint(equalTo: leftArrow.trailingAnchor, constant: 5),
            arrowFlat.centerYAnchor.constraint(equalTo: leftArrow.centerYAnchor)
        ])
    }
    
    func addGradientLabel() {
        letterLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 85, height: 100))
        letterLabel.text = "C"
        letterLabel.font = UIFont.noteFont
        letterLabel.textAlignment = .center
        letterLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLetterView.addSubview(letterLabel)

        noteLetterView.mask = letterLabel
    }
    
    func addGradientFlat() {
        let flatImageView = UIImageView(image: UIImage(named: "Flat")!.withTintColor(UIColor(named: "Black")!))
        letterFlat.addSubview(flatImageView)

        letterFlat.mask = flatImageView
    }
    
    func addGradientSharp() {
        let sharpImageView = UIImageView(image: UIImage(named: "Sharp")!.withTintColor(UIColor(named: "Black")!))
        letterSharp.addSubview(sharpImageView)

        letterSharp.mask = sharpImageView
    }
    
    func configureFingeringPageView() {
        fingeringPageViewController = FingeringPageViewController()
        fingeringPageViewController.fingerings = currentNoteFingering.fingerings
        fingeringPageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        add(fingeringPageViewController)
        
        NSLayoutConstraint.activate([
            fingeringPageViewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fingeringPageViewController.view.bottomAnchor.constraint(equalTo: noteLetterView.topAnchor, constant: -50),
            fingeringPageViewController.view.heightAnchor.constraint(equalToConstant: 40),
            fingeringPageViewController.view.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    func configureBottomStaff() {
        let width: CGFloat = view.bounds.width - 40
        let bottomInset: CGFloat = 200 - NotePickerViewController.spaceBetweenStaffLines * 2.5
        
        for i in 0..<5 {
            addStaffLine(bottomInset: bottomInset + (NotePickerViewController.spaceBetweenStaffLines * (4 - CGFloat(i))), width: width)
        }
        
        view.addSubview(trebleClefImageView)
        
        let leftIndicator = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 4, height: 200), rounded: true).withTintColor(UIColor(named: "OffWhite")!.withAlphaComponent(0.75)))
        leftIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftIndicator)
        
        let rightIndicator = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 4, height: 200), rounded: true).withTintColor(UIColor(named: "OffWhite")!.withAlphaComponent(0.75)))
        rightIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightIndicator)

        NSLayoutConstraint.activate([
            trebleClefImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            trebleClefImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomInset + 40),
            trebleClefImageView.heightAnchor.constraint(equalToConstant: 173),
            trebleClefImageView.widthAnchor.constraint(equalToConstant: 62),
            
            leftIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -45),
            leftIndicator.centerYAnchor.constraint(equalTo: trebleClefImageView.centerYAnchor),
            
            rightIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 45),
            rightIndicator.centerYAnchor.constraint(equalTo: trebleClefImageView.centerYAnchor),
        ])
    }
    
    func addStaffLine(bottomInset: CGFloat, width: CGFloat) {
        let staffImageView = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: width, height: 2), rounded: true).withTintColor(UIColor(named: "Black")!))
        staffImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(staffImageView)
        
        NSLayoutConstraint.activate([
            staffImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -bottomInset),
            staffImageView.heightAnchor.constraint(equalToConstant: 2),
            staffImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func configurePicker() {
        picker = NotePicker()
        picker.delegate = self
        picker.dataSource = self
        picker.collectionView.reloadData()
        picker.collectionView.register(NotePickerCell.self, forCellWithReuseIdentifier: NotePickerCell.reuseIdentifier)
        picker.cellSpacing = 0
        picker.cellSize = 87
        picker.selectedIndex = chartsController.currentChart.naturalNotes.firstIndex(of: chartsController.currentChart.centerNote)!
        picker.reloadData()
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            picker.heightAnchor.constraint(equalToConstant: NotePickerViewController.spaceBetweenStaffLines * 15.8)
        ])
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
    
    @objc func changeNoteType(swipe: UISwipeGestureRecognizer) {
        let swipeDirection = swipe.direction
        
        if swipeDirection == .left {
            if currentNoteType == .natural {
                currentNoteType = .sharp
                
                self.picker.reloadData()
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrowFlat.alpha = 0
                    self.rightArrow.alpha = 0
                    self.arrowSharp.alpha = 0
                    self.leftArrowNatural.alpha = 1
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            } else if currentNoteType == .flat {
                currentNoteType = .natural
                
                self.picker.reloadData()
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.rightArrowNatural.alpha = 0
                    self.arrowSharp.alpha = 1
                    self.leftArrow.alpha = 1
                    self.arrowFlat.alpha = 1
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            }
        } else {
            if currentNoteType == .natural {
                currentNoteType = .flat
                
                self.picker.reloadData()
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrowFlat.alpha = 0
                    self.leftArrow.alpha = 0
                    self.arrowSharp.alpha = 0
                    self.rightArrowNatural.alpha = 1
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            } else if currentNoteType == .sharp {
                currentNoteType = .natural
                
                self.picker.reloadData()
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.leftArrowNatural.alpha = 0
                    self.arrowFlat.alpha = 1
                    self.rightArrow.alpha = 1
                    self.arrowSharp.alpha = 1
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    @objc func settingsButtonTapped() {
        UIImpactFeedbackGenerator.lightTapticFeedbackOccurred()
        
        let vc = SettingsViewController(style: .insetGrouped)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func instrumentsButtonTapped() {
        // TODO: - Instruments
    }
    
    @objc func gridButtonTapped() {
        UIImpactFeedbackGenerator.mediumTapticFeedbackOccurred()
        
        let vc = NoteChartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackgroundGradient()
    }
}

extension NotePickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        
        let selectedNote = chartsController.currentNote(from: currentNoteType, index: index)
        let selectedFingering = chartsController.currentFingering(note: selectedNote)
        
        if currentNoteFingering != selectedFingering {
            UIImpactFeedbackGenerator.lightTapticFeedbackOccurred()
            
            currentNoteFingering = selectedFingering
            
            fingeringPageViewController.fingerings = currentNoteFingering.fingerings
            
            letterLabel.text = selectedNote.capitalizedLetter()
            
            showOrHideLetterAccidentals()
        }
    }
}

extension NotePickerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentNoteType {
        case .natural:
            return chartsController.currentChart.naturalNotes.count
        case .sharp:
            return chartsController.currentChart.sharpNotes.count
        case .flat:
            return chartsController.currentChart.flatNotes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotePickerCell.reuseIdentifier, for: indexPath) as! NotePickerCell
        
        switch currentNoteType {
        case .natural:
            cell.setNote(chartsController.currentChart.naturalNotes[indexPath.item])
        case .sharp:
            cell.setNote(chartsController.currentChart.sharpNotes[indexPath.item])
        case .flat:
            cell.setNote(chartsController.currentChart.flatNotes[indexPath.item])
        }
        
        cell.reloadViews()
        
        return cell
    }
}

#if DEBUG
import SwiftUI

struct NotePickerViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return NotePickerViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update code
    }
}

struct NotePickerViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotePickerViewControllerRepresentable()
                .previewDisplayName("iPhone 11 Pro Max")
                .previewDevice("iPhone 11 Pro Max")
            NotePickerViewControllerRepresentable()
                .preferredColorScheme(.dark)
                .previewDisplayName("iPhone SE (2nd generation)")
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
#endif

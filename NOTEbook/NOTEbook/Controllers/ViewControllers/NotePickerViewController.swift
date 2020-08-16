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
    
    var currentNoteFingering: NoteFingering! {
        didSet {
            letterArrowViewController.currentNoteFingering = currentNoteFingering
        }
    }
    
    var currentNoteType: NoteType = .natural {
        didSet {
            letterArrowViewController.currentNoteType = currentNoteType
        }
    }
    
    static let spaceBetweenStaffLines: CGFloat = 20
    
    var picker: NotePicker!
    var staffView: StaffView!
    var letterArrowViewController = LetterArrowViewController()
    var titleLabel = InstrumentTitleLabel()
    
    var staffCenterYAnchor: NSLayoutConstraint!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addBackgroundGradient()
        view.backgroundColor = UIColor(named: "White")
        
        addSwipeGestures()
        
        currentNoteFingering = chartsController.noteFingeringInCurrentChart(for: chartsController.currentChart.centerNote)
        
        configureTitleLabel()
        configureLetterArrowView()
        configurePicker()
        configureStaffView()
        configureIndicators()
        
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationItem.titleView = gridButton
        navigationItem.rightBarButtonItem = instrumentsBarButton
        
        if !UserDefaults.standard.bool(forKey: UserDefaults.Keys.tutorialHasShown) {
            UserDefaults.standard.setValue(true, forKey: UserDefaults.Keys.tutorialHasShown)
            navigationController?.present(TutorialViewController(), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadInstrumentViews()
    }
    
    func addSwipeGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changeNoteType))
        swipeLeft.numberOfTouchesRequired = 1
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changeNoteType))
        swipeRight.numberOfTouchesRequired = 1
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureLetterArrowView() {
        letterArrowViewController.view.translatesAutoresizingMaskIntoConstraints = false
        add(letterArrowViewController)
        
        NSLayoutConstraint.activate([
            letterArrowViewController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            letterArrowViewController.view.heightAnchor.constraint(equalToConstant: 250),
            letterArrowViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            letterArrowViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func configurePicker() {
        picker = NotePicker(screenWidth: view.bounds.width)
        picker.delegate = self
        picker.dataSource = self
        picker.collectionView.register(NotePickerCell.self, forCellWithReuseIdentifier: NotePickerCell.reuseIdentifier)
        picker.cellSpacing = 0
        picker.cellSize = 87
        picker.selectedIndex = chartsController.currentChart.naturalNotes.firstIndex(of: chartsController.currentChart.centerNote)!
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            picker.heightAnchor.constraint(equalToConstant: NotePickerViewController.spaceBetweenStaffLines * 18.1)
        ])
    }
    
    func configureStaffView() {
        let staffWidth = view.bounds.width - 40
        staffView = StaffView(width: staffWidth)
        staffView.isUserInteractionEnabled = false
        
        view.addSubview(staffView)
        
        NSLayoutConstraint.activate([
            staffView.centerXAnchor.constraint(equalTo: picker.centerXAnchor),
            staffView.widthAnchor.constraint(equalToConstant: staffWidth),
            staffView.heightAnchor.constraint(equalToConstant: NotePickerViewController.spaceBetweenStaffLines * 4)
        ])
        
        staffCenterYAnchor = staffView.centerYAnchor.constraint(equalTo: picker.centerYAnchor)
        staffCenterYAnchor.isActive = true
        
        updateStaffView()
    }
    
    func updateStaffView() {
        staffView.updateClef(with: chartsController.currentChart.instrument.clef)
        staffCenterYAnchor.constant = NotePickerViewController.spaceBetweenStaffLines * CGFloat(chartsController.currentChart.instrument.offset)
        view.layoutIfNeeded()
    }
    
    func configureIndicators() {
        let leftIndicator = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 4, height: 200), rounded: true).withTintColor(UIColor(named: "OffWhite")!.withAlphaComponent(0.75)))
        leftIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftIndicator)
        
        let rightIndicator = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 4, height: 200), rounded: true).withTintColor(UIColor(named: "OffWhite")!.withAlphaComponent(0.75)))
        rightIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightIndicator)
        
        NSLayoutConstraint.activate([
            leftIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -45),
            leftIndicator.centerYAnchor.constraint(equalTo: picker.centerYAnchor),
            
            rightIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 45),
            rightIndicator.centerYAnchor.constraint(equalTo: picker.centerYAnchor),
        ])
    }
    
    func reloadInstrumentViews() {
        picker.selectedIndex = chartsController.currentChart.naturalNotes.firstIndex(of: chartsController.currentChart.centerNote)!
        
        updateNoteType(to: .natural, animate: false)
        
        picker.reloadData()
        
        updateStaffView()
        
        titleLabel.text = chartsController.currentChart.instrument.type.rawValue
        
        letterArrowViewController.fingeringViewWidthConstraint.constant = CGFloat(chartsController.currentChart.instrument.fingeringWidth)
        letterArrowViewController.view.layoutIfNeeded()
    }
    
    @objc func changeNoteType(swipe: UISwipeGestureRecognizer) {
        if swipe.direction == .left {
            if currentNoteType == .natural {
                updateNoteType(to: .sharp)
            } else if currentNoteType == .flat {
                updateNoteType(to: .natural)
            }
        } else {
            if currentNoteType == .natural {
                updateNoteType(to: .flat)
            } else if currentNoteType == .sharp {
                updateNoteType(to: .natural)
            }
        }
        
        picker.reloadData()
    }
    
    func updateNoteType(to noteType: NoteType, animate: Bool = true) {
        UIView.animate(withDuration: (animate ? 0.5 : 0)) {
            if self.currentNoteType == .natural {
                if noteType == .sharp {
                    self.letterArrowViewController.arrowFlat.alpha = 0
                    self.letterArrowViewController.rightArrow.alpha = 0
                    self.letterArrowViewController.arrowSharp.alpha = 0
                    self.letterArrowViewController.leftArrowNatural.alpha = 1
                } else if noteType == .flat {
                    self.letterArrowViewController.arrowFlat.alpha = 0
                    self.letterArrowViewController.leftArrow.alpha = 0
                    self.letterArrowViewController.arrowSharp.alpha = 0
                    self.letterArrowViewController.rightArrowNatural.alpha = 1
                }
            } else if self.currentNoteType == .flat {
                self.letterArrowViewController.rightArrowNatural.alpha = 0
                self.letterArrowViewController.arrowSharp.alpha = 1
                self.letterArrowViewController.leftArrow.alpha = 1
                self.letterArrowViewController.arrowFlat.alpha = 1
            } else {
                self.letterArrowViewController.leftArrowNatural.alpha = 0
                self.letterArrowViewController.arrowFlat.alpha = 1
                self.letterArrowViewController.rightArrow.alpha = 1
                self.letterArrowViewController.arrowSharp.alpha = 1
            }
            
            self.view.isUserInteractionEnabled = false
        } completion: { _ in
            self.view.isUserInteractionEnabled = true
        }
        
        currentNoteType = noteType
    }
    
    @objc func settingsButtonTapped() {
        UIImpactFeedbackGenerator.lightTapticFeedbackOccurred()
        
        let vc = SettingsViewController(style: .insetGrouped)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func instrumentsButtonTapped() {
        let vc = InstrumentsViewController()
        navigationController?.pushViewController(vc, animated: true)
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
            
            letterArrowViewController.fingeringPageViewController.fingerings = currentNoteFingering.fingerings
            
            letterArrowViewController.letterLabel.text = selectedNote.capitalizedLetter()
            
            letterArrowViewController.showOrHideLetterAccidentals()
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

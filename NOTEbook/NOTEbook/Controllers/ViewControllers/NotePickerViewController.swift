//
//  ViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NotePickerViewController: UIViewController {
    private var chartsController = ChartsController.shared
    
    private var currentNoteFingering: NoteFingering! {
        didSet {
            letterArrowViewController.currentNoteFingering = currentNoteFingering
        }
    }
    
    private var currentNoteType: NoteType = .natural {
        didSet {
            letterArrowViewController.currentNoteType = currentNoteType
        }
    }
    
    static var spaceBetweenStaffLines: CGFloat = 20
    
    private var picker: NotePicker!
    private var staffView: StaffView!
    private var letterArrowViewController = LetterArrowViewController()
    private var titleLabel = InstrumentTitleLabel()
    
    private var staffCenterYAnchor: NSLayoutConstraint!
    private var leftIndicatorCenterYAnchor: NSLayoutConstraint!
    private var rightIndicatorCenterYAnchor: NSLayoutConstraint!
    
    private lazy var settingsBarButton: UIBarButtonItem = {
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "gear", withConfiguration: imageConfiguration)!
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsButtonTapped))
        
        return button
    }()
    
    private lazy var gridButton: UIButton = {
        let image = UIImage(named: "GridButton")!
        let pressedImage = UIImage(named: "PressedGridButton")!
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.setImage(pressedImage, for: .highlighted)
        button.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var instrumentsBarButton: UIBarButtonItem = {
        let image = UIImage(named: "InstrumentsButton")!
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(instrumentsButtonTapped))
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if view.bounds.height == 926.0 {
            // iPhone 12 Pro Max
            NotePickerViewController.spaceBetweenStaffLines = 26
        } else if view.bounds.height == 896.0 {
            // iPhone XR, XS Max, 11, 11 Pro Max
            NotePickerViewController.spaceBetweenStaffLines = 25
        } else if view.bounds.height == 844.0 {
            // iPhone 12, 12 Pro
            NotePickerViewController.spaceBetweenStaffLines = 24
        } else if view.bounds.height == 812.0 {
            // iPhone X, XS, 11 Pro, 12 mini
            NotePickerViewController.spaceBetweenStaffLines = 23
        } else if view.bounds.height == 736.0 {
            // iPhone 6S Plus, 7 Plus, 8 Plus
            NotePickerViewController.spaceBetweenStaffLines = 22
        } else if view.bounds.height == 667.0 {
            // iPhone 6S, 7, 8
            NotePickerViewController.spaceBetweenStaffLines = 20
        } else if view.bounds.height == 568 {
            // iPhone SE, SE (2nd Generation)
            NotePickerViewController.spaceBetweenStaffLines = 19
        }
        
        view.addBackgroundGradient()
        
        addSwipeGestures()
        
        currentNoteFingering = chartsController.noteFingeringInCurrentChart(for: chartsController.currentChart.centerNote)
        
        configureTitleLabel()
        configureLetterArrowView()
        configurePicker()
        configureStaffView()
        configureIndicators()
        
        navigationItem.backButtonTitle = "Note Picker"
        
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationItem.titleView = gridButton
        navigationItem.rightBarButtonItem = instrumentsBarButton
        
        if !UserDefaults.standard.bool(forKey: UserDefaults.Keys.tutorialHasShown) {
            UserDefaults.standard.setValue(true, forKey: UserDefaults.Keys.tutorialHasShown)
            navigationController?.present(TutorialViewController(), animated: true)
        }
        
        if Configuration.appConfiguration == .AppStore {
            StoreKitHelper.displayStoreKit()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadInstrumentViews()
    }
    
    private func addSwipeGestures() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changeNoteType))
        swipeLeft.numberOfTouchesRequired = 1
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changeNoteType))
        swipeRight.numberOfTouchesRequired = 1
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func configureLetterArrowView() {
        letterArrowViewController.view.translatesAutoresizingMaskIntoConstraints = false
        add(letterArrowViewController)
        
        NSLayoutConstraint.activate([
            letterArrowViewController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            letterArrowViewController.view.heightAnchor.constraint(equalToConstant: 220),
            letterArrowViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            letterArrowViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func configurePicker() {
        picker = NotePicker(screenWidth: view.bounds.width)
        picker.delegate = self
        picker.dataSource = self
        picker.collectionView.register(NotePickerCell.self, forCellWithReuseIdentifier: NotePickerCell.reuseIdentifier)
        picker.cellSpacing = 0
        picker.cellSize = 87 * NotePickerViewController.spaceBetweenStaffLines / 20
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
    
    private func configureStaffView() {
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
    
    private func updateStaffView() {
        staffView.updateClef(with: chartsController.currentChart.instrument.clef)
        staffCenterYAnchor.constant = NotePickerViewController.spaceBetweenStaffLines * CGFloat(chartsController.currentChart.instrument.offset)
        view.layoutIfNeeded()
    }
    
    private func configureIndicators() {
        let leftIndicator = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 4, height: 200), rounded: true).withTintColor(UIColor(named: "OffWhite")!.withAlphaComponent(0.75)))
        leftIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftIndicator)
        
        let rightIndicator = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: 4, height: 200), rounded: true).withTintColor(UIColor(named: "OffWhite")!.withAlphaComponent(0.75)))
        rightIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightIndicator)
        
        NSLayoutConstraint.activate([
            leftIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -45 * NotePickerViewController.spaceBetweenStaffLines / 20),
            
            rightIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 45 * NotePickerViewController.spaceBetweenStaffLines / 20),
        ])
        
        leftIndicatorCenterYAnchor = leftIndicator.centerYAnchor.constraint(equalTo: picker.centerYAnchor)
        leftIndicatorCenterYAnchor.isActive = true
        
        rightIndicatorCenterYAnchor = rightIndicator.centerYAnchor.constraint(equalTo: picker.centerYAnchor)
        rightIndicatorCenterYAnchor.isActive = true
        
        updateIndicators()
    }
    
    private func updateIndicators() {
        leftIndicatorCenterYAnchor.constant = NotePickerViewController.spaceBetweenStaffLines * CGFloat(chartsController.currentChart.instrument.offset)
        rightIndicatorCenterYAnchor.constant = NotePickerViewController.spaceBetweenStaffLines * CGFloat(chartsController.currentChart.instrument.offset)
        view.layoutIfNeeded()
    }
    
    private func reloadInstrumentViews() {
        picker.selectedIndex = chartsController.currentChart.naturalNotes.firstIndex(of: chartsController.currentChart.centerNote)!
        
        updateNoteType(to: .natural, animate: false)
        
        picker.reloadData()
        
        updateStaffView()
        updateIndicators()
        
        titleLabel.text = chartsController.currentChart.instrument.type.rawValue
        
        letterArrowViewController.fingeringViewWidthConstraint.constant = CGFloat(chartsController.currentChart.instrument.fingeringWidth)
        letterArrowViewController.view.layoutIfNeeded()
        
        letterArrowViewController.fingeringScrollingViewController.fingerings = currentNoteFingering.shorten(to: UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit))
    }
    
    @objc private func changeNoteType(swipe: UISwipeGestureRecognizer) {
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
    
    private func updateNoteType(to noteType: NoteType, animate: Bool = true) {
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
    
    @objc private func settingsButtonTapped() {
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
            UIImpactFeedbackGenerator.lightTapticFeedbackOccurred()
        }
        
        let vc = SettingsViewController(style: .insetGrouped)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func instrumentsButtonTapped() {
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
            UIImpactFeedbackGenerator.lightTapticFeedbackOccurred()
        }
        
        let vc = InstrumentsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func gridButtonTapped() {
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
            UIImpactFeedbackGenerator.mediumTapticFeedbackOccurred()
        }
        
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
            if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
                UIImpactFeedbackGenerator.lightTapticFeedbackOccurred()
            }
            
            currentNoteFingering = selectedFingering
            
            letterArrowViewController.fingeringScrollingViewController.fingerings = currentNoteFingering.shorten(to: UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit))
            
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
            cell.note = chartsController.currentChart.naturalNotes[indexPath.item]
        case .sharp:
            cell.note = chartsController.currentChart.sharpNotes[indexPath.item]
        case .flat:
            cell.note = chartsController.currentChart.flatNotes[indexPath.item]
        }
        
        cell.reloadViews()
        
        return cell
    }
}

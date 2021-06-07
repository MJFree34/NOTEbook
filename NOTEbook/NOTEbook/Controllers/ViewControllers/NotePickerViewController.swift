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
    private var leftIndicator: UIImageView!
    private var rightIndicator: UIImageView!
    private var tutorialView: TutorialView!
    private var letterArrowViewController = LetterArrowViewController()
    private var titleLabel = InstrumentTitleLabel()
    
    private var staffCenterYAnchor = NSLayoutConstraint()
    private var leftIndicatorCenterYAnchor = NSLayoutConstraint()
    private var rightIndicatorCenterYAnchor = NSLayoutConstraint()
    
    private lazy var settingsBarButton: UIBarButtonItem = {
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "gear", withConfiguration: imageConfiguration)!
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsButtonTapped))
        
        return button
    }()
    
    private lazy var gridButton: UIButton = {
        let image = UIImage(named: UIImage.Assets.gridButton)!
        let pressedImage = UIImage(named: UIImage.Assets.pressedGridButton)!
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.setImage(pressedImage, for: .highlighted)
        button.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var instrumentsBarButton: UIBarButtonItem = {
        let image = UIImage(named: UIImage.Assets.instrumentsButton)!
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(instrumentsButtonTapped))
        
        return button
    }()
    
    private lazy var visualEffectView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = nil
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(noteTypeIndexReceived), name: .noteTypeIndexReceived, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadInstrumentViews), name: .reloadInstrumentViews, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(tutorialDismissed), name: .tutorialDismissed, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addBackground()
        
        picker.firstIndexSelected = false
        
        if !UserDefaults.standard.bool(forKey: UserDefaults.Keys.tutorialHasShown) {
            displayTutorialView()
        } else {
            addSwipeGestures()
        }
        
        if Configuration.appConfiguration == .appStore {
            StoreKitHelper.displayStoreKit()
        }
        
        let iapFlowHasShown = UserDefaults.standard.bool(forKey: UserDefaults.Keys.iapFlowHasShown)
        let freeTrialOver = UserDefaults.standard.bool(forKey: UserDefaults.Keys.freeTrialOver)
        
        if !iapFlowHasShown && freeTrialOver {
            showAlert(title: "Trial Ended", message: "Your free trial has ended. Select your permanently free instrument now!", actionTitle: "Select instrument") { action in
                let vc = SelectInstrumentViewController()
                
                let nav = UINavigationController(rootViewController: vc)
                nav.setNavigationBarHidden(true, animated: false)
                nav.modalPresentationStyle = .fullScreen
                
                self.present(nav, animated: true)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        picker.endScroll()
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
        titleLabel.text = chartsController.currentChart.instrument.type.rawValue
        
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
        leftIndicator = UIImageView(image: UIImage.drawStaffLine(color: .notebookBlack, size: CGSize(width: 4, height: 200), rounded: true).withTintColor(.notebookOffWhite.withAlphaComponent(0.75)))
        leftIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftIndicator)
        
        rightIndicator = UIImageView(image: UIImage.drawStaffLine(color: .notebookBlack, size: CGSize(width: 4, height: 200), rounded: true).withTintColor(.notebookOffWhite.withAlphaComponent(0.75)))
        rightIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightIndicator)
        
        NSLayoutConstraint.activate([
            leftIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -45 * NotePickerViewController.spaceBetweenStaffLines / 20),
            rightIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 45 * NotePickerViewController.spaceBetweenStaffLines / 20)
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
    
    private func displayTutorialView() {
        guard tutorialView == nil else { return }
        
        let width: CGFloat = 300
        let height: CGFloat = 500
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        visualEffectView.alpha = 1
        view.addSubview(visualEffectView)
        
        tutorialView = TutorialView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        tutorialView.alpha = 1
        tutorialView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tutorialView)
        
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tutorialView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tutorialView.widthAnchor.constraint(equalToConstant: width),
            tutorialView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        tutorialView.setupTutorialPages()
    }
    
    @objc private func reloadInstrumentViews() {
        picker.selectedIndex = chartsController.currentChart.naturalNotes.firstIndex(of: chartsController.currentChart.centerNote)!
        currentNoteFingering = chartsController.noteFingeringInCurrentChart(for: chartsController.currentChart.centerNote)
        
        updateNoteType(to: .natural, animate: false) { _ in
            self.currentNoteType = .natural
            self.view.isUserInteractionEnabled = true
            self.picker.reloadData()
        }
        
        updateStaffView()
        updateIndicators()
        
        titleLabel.text = chartsController.currentChart.instrument.type.rawValue
        
        letterArrowViewController.fingeringScrollingViewWidthConstraint.constant = CGFloat(chartsController.currentChart.instrument.fingeringWidth)
        letterArrowViewController.view.layoutIfNeeded()
        
        letterArrowViewController.fingeringScrollingView.fingerings = currentNoteFingering.shorten(to: UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit))
    }
    
    @objc private func changeNoteType(swipe: UISwipeGestureRecognizer) {
        if swipe.direction == .left {
            if currentNoteType == .natural {
                updateNoteType(to: .sharp) { _ in
                    self.currentNoteType = .sharp
                    self.view.isUserInteractionEnabled = true
                    self.picker.reloadData()
                }
            } else if currentNoteType == .flat {
                updateNoteType(to: .natural) { _ in
                    self.currentNoteType = .natural
                    self.view.isUserInteractionEnabled = true
                    self.picker.reloadData()
                }
            }
        } else {
            if currentNoteType == .natural {
                updateNoteType(to: .flat) { _ in
                    self.currentNoteType = .flat
                    self.view.isUserInteractionEnabled = true
                    self.picker.reloadData()
                }
            } else if currentNoteType == .sharp {
                updateNoteType(to: .natural) { _ in
                    self.currentNoteType = .natural
                    self.view.isUserInteractionEnabled = true
                    self.picker.reloadData()
                }
            }
        }
    }
    
    private func updateNoteType(to noteType: NoteType, animate: Bool = true, completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: (animate ? 0.5 : 0), animations: {
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
        }, completion: completion)
    }
    
    @objc private func noteTypeIndexReceived(_ notification: Notification) {
        guard let noteType = notification.userInfo?["type"] as? NoteType else { return }
        guard let index = notification.userInfo?["index"] as? Int else { return }
        
        updateNoteType(to: noteType, animate: false) { _ in
            self.currentNoteType = noteType
            self.view.isUserInteractionEnabled = true
            self.picker.reloadData()
            self.picker.selectItem(at: index, animated: false)
        }
    }
    
    @objc private func tutorialDismissed() {
        UIView.animate(withDuration: 1) {
            self.tutorialView.alpha = 0
            self.visualEffectView.alpha = 0
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.view.isUserInteractionEnabled = false
        } completion: { _ in
            self.tutorialView.removeFromSuperview()
            self.tutorialView = nil
            self.visualEffectView.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
            
            self.addSwipeGestures()
            UserDefaults.standard.set(true, forKey: UserDefaults.Keys.tutorialHasShown)
        }
    }
    
    @objc private func settingsButtonTapped() {
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
            UIImpactFeedbackGenerator.lightTapticFeedbackOccurred()
        }
        
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func instrumentsButtonTapped() {
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
            UIImpactFeedbackGenerator.lightTapticFeedbackOccurred()
        }
        
        let vc = InstrumentsListViewController()
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
        
        view.addBackground()
        
        if tutorialView != nil {
            let pageIndex = tutorialView.pageIndex
            
            tutorialView.removeFromSuperview()
            tutorialView = nil
            
            displayTutorialView()
            tutorialView.select(index: pageIndex)
        }
    }
}

extension NotePickerViewController: UICollectionViewDelegate {}

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNote = chartsController.currentNote(from: currentNoteType, index: indexPath.item)
        let selectedFingering = chartsController.currentFingering(note: selectedNote)
        
        if currentNoteFingering != selectedFingering {
            if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
                UIImpactFeedbackGenerator.lightTapticFeedbackOccurred()
            }
            
            currentNoteFingering = selectedFingering
            
            letterArrowViewController.fingeringScrollingView.fingerings = currentNoteFingering.shorten(to: UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit))
            letterArrowViewController.letterLabel.text = selectedNote.capitalizedLetter()
            letterArrowViewController.showOrHideLetterAccidentals()
        }
    }
}

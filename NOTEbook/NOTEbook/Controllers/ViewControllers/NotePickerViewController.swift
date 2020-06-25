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
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changeNoteType))
        swipeLeft.numberOfTouchesRequired = 1
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changeNoteType))
        swipeRight.numberOfTouchesRequired = 1
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        
        currentNoteFingering = chartsController.noteFingeringInCurrentChart(for: chartsController.currentChart.startingNote)
        
        configureHeader()
        configureSwipeArrows()
        configureNoteLetter()
        configureFingeringPageView()
        configureBottomStaff()
        configurePicker()
    }
    
    func configureHeader() {
        let settingsImageConfiguration = UIImage.SymbolConfiguration(pointSize: 50, weight: .heavy)
        let settingsImage = UIImage(systemName: "gear", withConfiguration: settingsImageConfiguration)!
        let settingsButton = UIButton(type: .custom)
        settingsButton.setImage(settingsImage.withTintColor(UIColor(named: "DarkAqua")!, renderingMode: .alwaysOriginal), for: .normal)
        settingsButton.setImage(settingsImage.withTintColor(UIColor(named: "LightAqua")!, renderingMode: .alwaysOriginal), for: .highlighted)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsButton)
        
        let gridButtonImage = UIImage(named: "GridButton")!
        let gridButtonPressedImage = UIImage(named: "PressedGridButton")!
        let gridButton = UIButton(type: .custom)
        gridButton.setImage(gridButtonImage, for: .normal)
        gridButton.setImage(gridButtonPressedImage, for: .highlighted)
        gridButton.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridButton)
        
        let instrumentsButtonImage = UIImage(named: "InstrumentsButton")!
        let instrumentsButton = UIButton(type: .custom)
        instrumentsButton.setImage(instrumentsButtonImage.withTintColor(UIColor(named: "DarkAqua")!, renderingMode: .alwaysOriginal), for: .normal)
        instrumentsButton.setImage(instrumentsButtonImage.withTintColor(UIColor(named: "LightAqua")!, renderingMode: .alwaysOriginal), for: .highlighted)
        instrumentsButton.addTarget(self, action: #selector(instrumentsButtonTapped), for: .touchUpInside)
        instrumentsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instrumentsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            settingsButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 50),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            
            gridButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gridButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            gridButton.heightAnchor.constraint(equalToConstant: 50),
            gridButton.widthAnchor.constraint(equalToConstant: 50),
            
            instrumentsButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            instrumentsButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            instrumentsButton.widthAnchor.constraint(equalToConstant: 50),
            instrumentsButton.heightAnchor.constraint(equalToConstant: 50),
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
            rightArrow.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
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
    
    func configureNoteLetter() {
        addGradientLabel()
        view.addSubview(noteLetterView)
        
        letterFlat.alpha = 0
        addGradientFlat()
        view.addSubview(letterFlat)
        
        letterSharp.alpha = 0
        addGradientSharp()
        view.addSubview(letterSharp)
        
        NSLayoutConstraint.activate([
            noteLetterView.centerYAnchor.constraint(equalTo: leftArrow.centerYAnchor),
            noteLetterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noteLetterView.heightAnchor.constraint(equalToConstant: 100),
            noteLetterView.widthAnchor.constraint(equalToConstant: 85),
            
            letterFlat.centerYAnchor.constraint(equalTo: leftArrow.centerYAnchor),
            letterFlat.leadingAnchor.constraint(equalTo: noteLetterView.trailingAnchor),
            letterFlat.heightAnchor.constraint(equalToConstant: 60),
            letterFlat.widthAnchor.constraint(equalToConstant: 18.25),
            
            letterSharp.centerYAnchor.constraint(equalTo: leftArrow.centerYAnchor),
            letterSharp.leadingAnchor.constraint(equalTo: noteLetterView.trailingAnchor),
            letterSharp.heightAnchor.constraint(equalToConstant: 68),
            letterSharp.widthAnchor.constraint(equalToConstant: 26.87),
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
            fingeringPageViewController.view.bottomAnchor.constraint(equalTo: noteLetterView.topAnchor, constant: -100),
            fingeringPageViewController.view.heightAnchor.constraint(equalToConstant: 40),
            fingeringPageViewController.view.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    func configureBottomStaff() {
        let width: CGFloat = view.bounds.width - 40
        let bottomInset: CGFloat = view.bounds.height / 4 - letterLabel.bounds.height / 2 - NotePickerViewController.spaceBetweenStaffLines * 2
        
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
        picker.selectedIndex = chartsController.currentChart.naturalNotes.firstIndex(of: chartsController.currentChart.startingNote)!
        picker.reloadData()
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            picker.centerYAnchor.constraint(equalTo: trebleClefImageView.centerYAnchor, constant: -2.5),
            picker.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    @objc func changeNoteType(swipe: UISwipeGestureRecognizer) {
        let swipeDirection = swipe.direction
        
        if swipeDirection == .left {
            if currentNoteType == .natural {
                currentNoteType = .sharp
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.fingeringPageViewController.view.alpha = 0
                }) { _ in
                    self.fingeringPageViewController.fingerings = self.chartsController.noteFingeringInCurrentChart(for: self.chartsController.currentChart.startingNote.nextNote())!.fingerings
                    
                    self.picker.reloadData()
                    
                    UIView.animate(withDuration: 0.25) {
                        self.fingeringPageViewController.view.alpha = 1
                    }
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrowFlat.alpha = 0
                    self.rightArrow.alpha = 0
                    self.arrowSharp.alpha = 0
                    self.leftArrowNatural.alpha = 1
                    self.letterSharp.alpha = 1
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            } else if currentNoteType == .flat {
                currentNoteType = .natural
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.fingeringPageViewController.view.alpha = 0
                }) { _ in
                    self.fingeringPageViewController.fingerings = self.chartsController.noteFingeringInCurrentChart(for: self.chartsController.currentChart.startingNote)!.fingerings
                    
                    self.picker.reloadData()
                    
                    UIView.animate(withDuration: 0.25) {
                        self.fingeringPageViewController.view.alpha = 1
                    }
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.rightArrowNatural.alpha = 0
                    self.arrowSharp.alpha = 1
                    self.leftArrow.alpha = 1
                    self.arrowFlat.alpha = 1
                    self.letterFlat.alpha = 0
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            }
        } else {
            if currentNoteType == .natural {
                currentNoteType = .flat
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.fingeringPageViewController.view.alpha = 0
                }) { _ in
                    self.fingeringPageViewController.fingerings = self.chartsController.noteFingeringInCurrentChart(for: self.chartsController.currentChart.startingNote.previousNote())!.fingerings
                    
                    self.picker.reloadData()
                    
                    UIView.animate(withDuration: 0.25) {
                        self.fingeringPageViewController.view.alpha = 1
                    }
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrowFlat.alpha = 0
                    self.leftArrow.alpha = 0
                    self.arrowSharp.alpha = 0
                    self.rightArrowNatural.alpha = 1
                    self.letterFlat.alpha = 1
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            } else if currentNoteType == .sharp {
                currentNoteType = .natural
                
                UIView.animate(withDuration: 0.25, animations: {
                    self.fingeringPageViewController.view.alpha = 0
                }) { _ in
                    self.fingeringPageViewController.fingerings = self.chartsController.noteFingeringInCurrentChart(for: self.chartsController.currentChart.startingNote)!.fingerings
                    
                    self.picker.reloadData()
                    
                    UIView.animate(withDuration: 0.25) {
                        self.fingeringPageViewController.view.alpha = 1
                    }
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.leftArrowNatural.alpha = 0
                    self.arrowFlat.alpha = 1
                    self.rightArrow.alpha = 1
                    self.arrowSharp.alpha = 1
                    self.letterSharp.alpha = 0
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    @objc func settingsButtonTapped() {
        // TODO: - Settings
    }
    
    @objc func instrumentsButtonTapped() {
        // TODO: - Instruments
    }
    
    @objc func gridButtonTapped() {
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
        print("Selected index: \(index)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Scroll: \(scrollView.contentOffset.x)")
    }
}

extension NotePickerViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
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
        
        return cell
    }
}

//#if DEBUG
//import SwiftUI
//
//struct NotePickerViewRepresentable: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//        return NotePickerViewController().view
//    }
//    
//    func updateUIView(_ view: UIView, context: Context) {
//        // Update your code here
//    }
//}
//
//@available(iOS 13.0, *)
//struct NotePickerViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        Group {
//            NotePickerViewRepresentable()
//                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
//                .previewDisplayName("iPhone XS Max")
//            
//            NotePickerViewRepresentable()
//                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
//                .previewDisplayName("iPhone SE")
//        }
//    }
//}
//#endif

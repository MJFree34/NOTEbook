//
//  NoteChartViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NoteChartViewController: UIViewController {
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.dataSource = self
        cv.delegate = self
        cv.alwaysBounceVertical = true
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.register(NoteChartCell.self, forCellWithReuseIdentifier: NoteChartCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    var chartsController = ChartsController.shared
    
    lazy var settingsBarButton: UIBarButtonItem = {
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "gear", withConfiguration: imageConfiguration)!
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsButtonTapped))
        
        return button
    }()
    
    lazy var pickerButton: UIButton = {
        let image = UIImage(named: "PickerButton")!
        let pressedImage = UIImage(named: "PressedPickerButton")!
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.setImage(pressedImage, for: .highlighted)
        button.addTarget(self, action: #selector(pickerButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var instrumentsBarButton: UIBarButtonItem = {
        let image = UIImage(named: "InstrumentsButton")!
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(instrumentsButtonTapped))
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        view.addBackgroundGradient()
        
        configureCollectionView()
        
        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationItem.titleView = pickerButton
//        navigationItem.rightBarButtonItem = instrumentsBarButton
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func settingsButtonTapped() {
        let vc = SettingsViewController(style: .insetGrouped)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func instrumentsButtonTapped() {
        // TODO: - Instruments
    }
    
    @objc func pickerButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackgroundGradient()
    }
}

extension NoteChartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chartsController.numberOfNoteFingeringsInCurrentChart
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteChartCell.reuseIdentifier, for: indexPath) as? NoteChartCell else { fatalError("Unable to dequeue a NoteChartCell") }
        
        cell.configureCell(collectionViewWidth: collectionView.bounds.width, noteFingering: chartsController.currentChart.noteFingerings[indexPath.item])
        
        return cell
    }
}

extension NoteChartViewController: UICollectionViewDelegate {}

extension NoteChartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3, height: NoteChartCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

#if DEBUG
import SwiftUI

struct NoteChartViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return NoteChartViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update code
    }
}

struct NoteChartViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NoteChartViewControllerRepresentable()
                .previewDisplayName("iPhone 11 Pro Max")
                .previewDevice("iPhone 11 Pro Max")
            NoteChartViewControllerRepresentable()
                .preferredColorScheme(.dark)
                .previewDisplayName("iPhone SE (2nd generation)")
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
#endif

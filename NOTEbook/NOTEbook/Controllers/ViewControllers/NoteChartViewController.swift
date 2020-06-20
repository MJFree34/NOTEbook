//
//  NoteChartViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NoteChartViewController: UIViewController {
    var collectionView: UICollectionView!
    
    var chartsController = ChartsController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        view.addBackgroundGradient()
        
        configureHeader()
        configureCollectionView()
    }
    
    func configureHeader() {
        let settingsImageConfiguration = UIImage.SymbolConfiguration(pointSize: 50, weight: .heavy)
        let settingsImage = UIImage(systemName: "gear", withConfiguration: settingsImageConfiguration)!
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(settingsImage.withTintColor(UIColor(named: "DarkAqua")!, renderingMode: .alwaysOriginal), for: .normal)
        settingsButton.setImage(settingsImage.withTintColor(UIColor(named: "LightAqua")!, renderingMode: .alwaysOriginal), for: .highlighted)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsButton)
        
        let pickerButtonImage = UIImage(named: "PickerButton")!
        let pickerButtonPressedImage = UIImage(named: "PressedPickerButton")!
        let pickerButton = UIButton(type: .custom)
        pickerButton.setImage(pickerButtonImage, for: .normal)
        pickerButton.setImage(pickerButtonPressedImage, for: .highlighted)
        pickerButton.addTarget(self, action: #selector(pickerButtonTapped), for: .touchUpInside)
        pickerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerButton)
        
        let instrumentsButtonImage = UIImage(named: "InstrumentsButton")!
        let instrumentsButton = UIButton(type: .custom)
        instrumentsButton.setImage(instrumentsButtonImage, for: .normal)
        instrumentsButton.setImage(instrumentsButtonImage.withTintColor(UIColor(named: "LightAqua")!, renderingMode: .alwaysOriginal), for: .highlighted)
        instrumentsButton.addTarget(self, action: #selector(instrumentsButtonTapped), for: .touchUpInside)
        instrumentsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instrumentsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            settingsButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 50),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            
            pickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            pickerButton.heightAnchor.constraint(equalToConstant: 50),
            pickerButton.widthAnchor.constraint(equalToConstant: 50),
            
            instrumentsButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            instrumentsButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            instrumentsButton.widthAnchor.constraint(equalToConstant: 50),
            instrumentsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(NoteChartCell.self, forCellWithReuseIdentifier: NoteChartCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 70),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func settingsButtonTapped() {
        // TODO: - Settings
    }
    
    @objc func instrumentsButtonTapped() {
        // TODO: - Instruments
    }
    
    @objc func pickerButtonTapped() {
        navigationController?.popViewController(animated: true)
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

extension NoteChartViewController: UICollectionViewDelegate {
    
}

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

struct NoteChartViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return NoteChartViewController().view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        // Update your code here
    }
}

@available(iOS 13.0, *)
struct NoteChartViewController_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            NoteChartViewRepresentable()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            
            NoteChartViewRepresentable()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
                .previewDisplayName("iPhone SE")
        }
    }
}
#endif

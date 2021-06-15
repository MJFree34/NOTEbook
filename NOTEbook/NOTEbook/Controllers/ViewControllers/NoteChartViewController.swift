//
//  NoteChartViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NoteChartViewController: UIViewController {
    private var chartsController = ChartsController.shared
    
    private lazy var collectionView: ChartCollectionView = {
        let chart = ChartCollectionView(reuseIdentifiers: [NoteChartCell.reuseIdentifier])
        chart.dataSource = self
        chart.delegate = self
        chart.register(TitleCell.self,
                       forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                       withReuseIdentifier: TitleCell.reuseIdentifier)
        return chart
    }()
    
    private lazy var settingsBarButton: UIBarButtonItem = {
        let imageConfiguration = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "gear", withConfiguration: imageConfiguration)!
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(settingsButtonTapped))
        return button
    }()
    
    private lazy var pickerButton: UIButton = {
        let image = UIImage(named: UIImage.Assets.pickerButton)!
        let pressedImage = UIImage(named: UIImage.Assets.pressedPickerButton)!
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.setImage(pressedImage, for: .highlighted)
        button.addTarget(self, action: #selector(pickerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var instrumentsBarButton: UIBarButtonItem = {
        let image = UIImage(named: UIImage.Assets.instrumentsButton)!
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(instrumentsButtonTapped))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        configureCollectionView()
        
        navigationItem.backButtonTitle = "Chart"
        navigationItem.leftBarButtonItem = settingsBarButton
        navigationItem.titleView = pickerButton
        navigationItem.rightBarButtonItem = instrumentsBarButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addBackground()
        
        // Scrolls to the very top
        collectionView.reloadData()
        collectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func performHaptics(light: Bool) {
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
            if light {
                UIImpactFeedbackGenerator.lightTapticFeedbackOccurred()
            } else {
                UIImpactFeedbackGenerator.mediumTapticFeedbackOccurred()
            }
        }
    }
    
    @objc
    private func settingsButtonTapped() {
        performHaptics(light: true)
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func instrumentsButtonTapped() {
        performHaptics(light: true)
        let vc = InstrumentsListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func pickerButtonTapped() {
        performHaptics(light: false)
        navigationController?.popViewController(animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackground()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteFingering = chartsController.currentChart.noteFingerings[indexPath.row]
        let firstNote = noteFingering.notes[0]
        
        if let naturalIndex = chartsController.currentChart.naturalNotes.firstIndex(of: firstNote) {
            let userInfo = ["type" : NoteType.natural, "index" : naturalIndex] as [String : Any]
            NotificationCenter.default.post(name: .noteTypeIndexReceived, object: nil, userInfo: userInfo)
        } else if let sharpIndex = chartsController.currentChart.sharpNotes.firstIndex(of: firstNote) {
            let userInfo = ["type" : NoteType.sharp, "index" : sharpIndex] as [String : Any]
            
            NotificationCenter.default.post(name: .noteTypeIndexReceived, object: nil, userInfo: userInfo)
        } else {
            // Means this is the first note chosen and sharp does not exist, only flats (which can be a natural B or E)
            if let naturalNoteFlatIndex = chartsController.currentChart.flatNotes.firstIndex(of: firstNote) {
                let userInfo = ["type" : NoteType.flat, "index" : naturalNoteFlatIndex] as [String : Any]
                NotificationCenter.default.post(name: .noteTypeIndexReceived, object: nil, userInfo: userInfo)
            } else {
                let secondNote = noteFingering.notes[1]
                let flatIndex = chartsController.currentChart.flatNotes.firstIndex(of: secondNote)!
                let userInfo = ["type" : NoteType.flat, "index" : flatIndex] as [String : Any]
                NotificationCenter.default.post(name: .noteTypeIndexReceived, object: nil, userInfo: userInfo)
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}

extension NoteChartViewController: UICollectionViewDelegate {}

extension NoteChartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3, height: CGFloat(chartsController.chartCellHeight()))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let titleCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                              withReuseIdentifier: TitleCell.reuseIdentifier,
                                                                              for: indexPath) as? TitleCell else { fatalError() }
        titleCell.titleLabel.text = chartsController.currentChart.instrument.type.rawValue
        return titleCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 25)
    }
}

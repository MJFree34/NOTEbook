//
//  SelectInstrumentViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 12/11/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class SelectInstrumentViewController: UIViewController {
    private let chartsController = ChartsController.shared
    
    private var selectedCellIndex: IndexPath?
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.dataSource = self
        cv.delegate = self
        cv.alwaysBounceVertical = false
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.register(SelectInstrumentCell.self, forCellWithReuseIdentifier: SelectInstrumentCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose Your Instrument"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textColor = UIColor(named: "MediumRed")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "This instrument group will be free forever!"
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.01
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: "DarkAqua")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "DarkAqua")
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(UIColor(named: "LightestestAqua"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(collectionView)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 20),
            
            collectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addBackground()
    }
    
    @objc private func continuePressed() {
        // TODO: - Push next screen and save selection while not doing anything when no selection
        dismiss(animated: true)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackgroundGradient()
    }
}

extension SelectInstrumentViewController: UICollectionViewDelegate {}

extension SelectInstrumentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chartsController.purchasableInstrumentGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectInstrumentCell.reuseIdentifier, for: indexPath) as? SelectInstrumentCell else { fatalError() }
        cell.purchasableInstrumentGroup = chartsController.purchasableInstrumentGroups[indexPath.item]
        cell.setupSubviews()
        cell.backgroundColor = UIColor(named: "LightestAqua")
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = UIColor(named: "MediumRed")?.cgColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SelectInstrumentCell else { fatalError() }
        
        if let selectedCellIndex = selectedCellIndex {
            guard let cell2 = collectionView.cellForItem(at: selectedCellIndex) as? SelectInstrumentCell else { fatalError() }
            
            cell2.layer.borderWidth = 0
        }
        
        cell.layer.borderWidth = 2
        
        selectedCellIndex = indexPath
    }
}

extension SelectInstrumentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 20) / 3, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

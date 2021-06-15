//
//  SelectInstrumentViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 12/11/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class SelectInstrumentViewController: PurchaseViewController {
    private lazy var collectionView: ChartCollectionView = {
        let chart = ChartCollectionView(reuseIdentifiers: [SelectInstrumentCell.reuseIdentifier])
        chart.dataSource = self
        chart.delegate = self
        return chart
    }()
    
    private lazy var titleLabel = PurchaseTitleLabel(title: "Choose Your Instrument")
    private lazy var subtitleLabel = PurchaseSubtitleLabel(title: "This instrument group will be free forever!")
    
    private lazy var continueButton: ContinueButton = {
        let button = ContinueButton(title: "Continue", normalTitleColor: .notebookLightestestAqua)
        button.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
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
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -10),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc
    private func continuePressed() {
        if let selectedInteger = selectedCellIndex?.item {
            UserDefaults.standard.set(selectedInteger, forKey: UserDefaults.Keys.chosenFreeInstrumentGroupIndex)
            UserDefaults.standard.set(true, forKey: UserDefaults.Keys.iapFlowHasShown)
            chartsController.updatePurchasableInstrumentGroups(resetIndex: true)

            let vc = PurchaseInstrumentsViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension SelectInstrumentViewController: UICollectionViewDelegate {}

extension SelectInstrumentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chartsController.purchasableInstrumentGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectInstrumentCell.reuseIdentifier,
                                                            for: indexPath) as? SelectInstrumentCell else { fatalError() }
        cell.purchasableInstrumentGroup = chartsController.purchasableInstrumentGroups[indexPath.item]
        cell.setupSubviews()
        cell.backgroundColor = .notebookLightestAqua
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = UIColor.notebookMediumRed.cgColor
        
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

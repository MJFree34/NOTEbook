//
//  PurchaseInstrumentsViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 12/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Purchases
import UIKit

class PurchaseInstrumentsViewController: UIViewController {
    private let chartsController = ChartsController.shared
    private var selectedCellIndex: IndexPath?
    private var packages = [Purchases.Package]()
    
    private lazy var allPurchasableInstrumentGroup: PurchasableInstrumentGroup = {
        var titles = [String]()
        
        for group in chartsController.purchasableInstrumentGroups {
            titles.append(group.groupTitle)
        }
        
        return PurchasableInstrumentGroup(groupTitle: "All", instrumentTitles: titles)
    }()
    
    private lazy var woodwindsPurchasableInstrumentGroup: PurchasableInstrumentGroup = {
        var titles = [String]()
        
        for group in chartsController.purchasableInstrumentGroups[0..<3] {
            titles.append(group.groupTitle)
        }
        
        return PurchasableInstrumentGroup(groupTitle: "Woodwinds", instrumentTitles: titles)
    }()
    
    private lazy var brassPurchasableInstrumentGroup: PurchasableInstrumentGroup = {
        var titles = [String]()
        
        for group in chartsController.purchasableInstrumentGroups[3..<chartsController.purchasableInstrumentGroups.count] {
            titles.append(group.groupTitle)
        }
        
        return PurchasableInstrumentGroup(groupTitle: "Brass", instrumentTitles: titles)
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.dataSource = self
        cv.delegate = self
        cv.alwaysBounceVertical = true
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.register(PurchaseInstrumentSmallCell.self, forCellWithReuseIdentifier: PurchaseInstrumentSmallCell.reuseIdentifier)
        cv.register(PurchaseInstrumentLargeCell.self, forCellWithReuseIdentifier: PurchaseInstrumentLargeCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Unlock Instruments"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textColor = UIColor(named: "MediumRed")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Permanently unlock instrument groups, including future instruments of that group!"
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.01
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: "DarkAqua")
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
        button.backgroundColor = UIColor(named: "DarkAqua")
        button.setTitle("Close", for: .normal)
        button.setTitleColor(UIColor(named: "LightestestAqua"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPackages()
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -20),
            
            closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addBackground()
    }
    
    private func loadPackages() {
        loadingIndicator.startAnimating()
        closeButton.isEnabled = false
                
        Purchases.shared.offerings { (offerings, error) in
            if error != nil {
                self.showAlert(title: "Error", message: "Unable to fetch offerings") { (action) in
                    self.dismiss(animated: true)
                }
            }
            
            if let packages = offerings?.current?.availablePackages {
                self.packages = packages
            }
            
            if self.packages.count == 0 {
                self.showAlert(title: "Error", message: "No packages found") { (action) in
                    self.dismiss(animated: true)
                }
            }
            
            self.loadingIndicator.stopAnimating()
            self.collectionView.reloadData()
            self.closeButton.isEnabled = true
        }
    }
    
    @objc private func continuePressed() {
        // TODO: - Purchase selected item if anything selected before dismissing
        if let selectedIndex = selectedCellIndex {
            let index: Int
            
            switch selectedIndex.section {
            case 0:
                index = selectedIndex.row
            case 1:
                index = selectedIndex.row + 1
            case 2:
                index = selectedIndex.row + 3
            default:
                fatalError()
            }
            
            
            Purchases.shared.purchasePackage(packages[index]) { (transaction, purchaserInfo, error, userCancelled) in
                if !userCancelled {
                    self.navigationController?.dismiss(animated: true)
                }
            }
        } else {
            dismiss(animated: true)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackgroundGradient()
    }
}

extension PurchaseInstrumentsViewController: UICollectionViewDelegate {}

extension PurchaseInstrumentsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if packages.count != 0 {
            switch section {
            case 0:
                return 1
            case 1:
                return 2
            case 2:
                return packages.count - 3
            default:
                return 0
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchaseInstrumentLargeCell.reuseIdentifier, for: indexPath) as? PurchaseInstrumentLargeCell else { fatalError() }
            cell.purchasableInstrumentGroup = allPurchasableInstrumentGroup
            cell.package = packages[indexPath.item]
            cell.setupSubviews()
            cell.backgroundColor = UIColor(named: "LightestAqua")
            cell.layer.cornerRadius = 20
            cell.layer.borderColor = UIColor(named: "MediumRed")?.cgColor
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchaseInstrumentSmallCell.reuseIdentifier, for: indexPath) as? PurchaseInstrumentSmallCell else { fatalError() }
            cell.package = packages[indexPath.item + 1]
            
            switch indexPath.item {
            case 0:
                cell.purchasableInstrumentGroup = woodwindsPurchasableInstrumentGroup
            case 1:
                cell.purchasableInstrumentGroup = brassPurchasableInstrumentGroup
            default:
                fatalError()
            }
            
            cell.setupSubviews()
            cell.backgroundColor = UIColor(named: "LightestAqua")
            cell.layer.cornerRadius = 20
            cell.layer.borderColor = UIColor(named: "MediumRed")?.cgColor
            
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchaseInstrumentSmallCell.reuseIdentifier, for: indexPath) as? PurchaseInstrumentSmallCell else { fatalError() }
            cell.purchasableInstrumentGroup = chartsController.purchasableInstrumentGroups[indexPath.item]
            cell.package = packages[indexPath.item + 3]
            cell.setupSubviews()
            cell.backgroundColor = UIColor(named: "LightestAqua")
            cell.layer.cornerRadius = 20
            cell.layer.borderColor = UIColor(named: "MediumRed")?.cgColor
            
            return cell
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let cell = collectionView.cellForItem(at: indexPath) as? PurchaseInstrumentLargeCell else { fatalError() }
            
            guard selectedCellIndex != indexPath else {
                closeButton.setTitle("Close", for: .normal)
                cell.layer.borderWidth = 0
                selectedCellIndex = nil
                
                return
            }
            
            if let selectedCellIndex = selectedCellIndex {
                if selectedCellIndex.section == 0 {
                    guard let cell2 = collectionView.cellForItem(at: selectedCellIndex) as? PurchaseInstrumentLargeCell else { fatalError() }
                    
                    cell2.layer.borderWidth = 0
                } else {
                    guard let cell2 = collectionView.cellForItem(at: selectedCellIndex) as? PurchaseInstrumentSmallCell else { fatalError() }
                    
                    cell2.layer.borderWidth = 0
                }
            }
            
            cell.layer.borderWidth = 2
        } else {
            guard let cell = collectionView.cellForItem(at: indexPath) as? PurchaseInstrumentSmallCell else { fatalError() }
            
            guard selectedCellIndex != indexPath else {
                closeButton.setTitle("Close", for: .normal)
                cell.layer.borderWidth = 0
                selectedCellIndex = nil
                
                return
            }
            
            if let selectedCellIndex = selectedCellIndex {
                if selectedCellIndex.section == 0 {
                    guard let cell2 = collectionView.cellForItem(at: selectedCellIndex) as? PurchaseInstrumentLargeCell else { fatalError() }
                    
                    cell2.layer.borderWidth = 0
                } else {
                    guard let cell2 = collectionView.cellForItem(at: selectedCellIndex) as? PurchaseInstrumentSmallCell else { fatalError() }
                    
                    cell2.layer.borderWidth = 0
                }
            }
            
            cell.layer.borderWidth = 2
        }
        
        selectedCellIndex = indexPath
        closeButton.setTitle("Purchase", for: .normal)
    }
}

extension PurchaseInstrumentsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: (collectionView.bounds.width - 20) / 3 * 2 + 10, height: 150)
        }
        
        return CGSize(width: (collectionView.bounds.width - 20) / 3, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let largeCellWidth = (collectionView.bounds.width - 20) / 3 * 2 + 10
        
        return UIEdgeInsets(top: 0, left: (section == 0 ? (collectionView.bounds.width - largeCellWidth) / -1 + 0.1 : 0), bottom: 10, right: 0)
    }
}

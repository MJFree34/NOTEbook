//
//  PurchaseInstrumentsViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 12/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Purchases
import UIKit

enum OfferingType {
    case current
    case woodwindsDiscounted
    case brassDiscounted
    case woodwindsBrassDiscounted
    case allDiscountedWoodwindInstruments
    case allDiscountedBrassInstruments
    case allDiscounted
    case none
}

enum PurchasesErrorType {
    case unableToFetchOfferings
    case noCurrentOfferingsFound
    case noDiscountedOfferingsFound
    case noPackagesFound
}

class PurchaseInstrumentsViewController: PurchaseViewController {
    private var packages: [Purchases.Package] = []
    private var offeringType = OfferingType.current
    
    private lazy var allPurchasableInstrumentGroup: PurchasableInstrumentGroup = {
        var titles = [String]()
        
        for group in chartsController.purchasableInstrumentGroups {
            titles.append(group.groupTitle)
        }
        
        titles.append("Future instruments")
        
        return PurchasableInstrumentGroup(groupTitle: "All", instrumentTitles: titles)
    }()
    
    private lazy var woodwindsPurchasableInstrumentGroup: PurchasableInstrumentGroup = {
        var titles = [String]()
        
        for group in chartsController.purchasableInstrumentGroups {
            if group.groupTitle == "Flute" || group.groupTitle == "Clarinet" || group.groupTitle == "Saxophone" {
                titles.append(group.groupTitle)
            }
        }
        
        return PurchasableInstrumentGroup(groupTitle: "Woodwinds", instrumentTitles: titles)
    }()
    
    private lazy var brassPurchasableInstrumentGroup: PurchasableInstrumentGroup = {
        var titles = [String]()
        
        for group in chartsController.purchasableInstrumentGroups {
            if group.groupTitle == "Trumpet" || group.groupTitle == "French Horn" || group.groupTitle == "Trombone" || group.groupTitle == "Euphonium" || group.groupTitle == "Tuba" {
                titles.append(group.groupTitle)
            }
        }
        
        return PurchasableInstrumentGroup(groupTitle: "Brass", instrumentTitles: titles)
    }()
    
    private lazy var collectionView: ChartCollectionView = {
        let chart = ChartCollectionView(reuseIdentifiers: [PurchaseInstrumentSmallCell.reuseIdentifier, PurchaseInstrumentLargeCell.reuseIdentifier])
        chart.dataSource = self
        chart.delegate = self
        return chart
    }()
    
    private lazy var titleLabel = PurchaseTitleLabel(title: "Unlock Instruments")
    private lazy var subtitleLabel = PurchaseSubtitleLabel(title: "Permanently unlock instrument groups, including future instruments of that group!")
    
    private lazy var closeButton: ContinueButton = {
        let button = ContinueButton(title: "Close", normalTitleColor: .notebookLightestestAqua)
        button.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
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
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(collectionView)
        view.addSubview(closeButton)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            collectionView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -10),
            
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
        loadPackages()
    }
    
    private func loadPackages() {
        loadingIndicator.startAnimating()
        closeButton.isEnabled = false
        
        var availableOfferings: Purchases.Offerings?
        
        Purchases.shared.offerings { offerings, error in
            if error != nil {
                self.showErrorAlert(errorType: .unableToFetchOfferings)
            }
            
            availableOfferings = offerings
        }
        
        Purchases.shared.purchaserInfo { purchaserInfo, error in
            guard let defaultPackages = availableOfferings?.offering(identifier: "default")?.availablePackages else {
                self.showErrorAlert(errorType: .noCurrentOfferingsFound)
                return
            }
            
            // Saves the price of a single instrument for discounting
            let flutePriceString = defaultPackages[3].product.price
            UserDefaults.standard.set(flutePriceString, forKey: UserDefaults.Keys.instrumentPrice)
            
            self.setOfferingType(purchaserInfo: purchaserInfo)
            
            switch self.offeringType {
            case .none:
                self.packages = []
            case .allDiscounted:
                guard let allDiscountedPackages = availableOfferings?.offering(identifier: "all-discounted")?.availablePackages else {
                    self.showErrorAlert(errorType: .noDiscountedOfferingsFound)
                    return
                }
                self.packages = allDiscountedPackages
            case .allDiscountedBrassInstruments:
                guard let allDiscountedBrassInstrumentsPackages = availableOfferings?.offering(identifier:
                                                                                                "all-discounted-brass-instruments")?.availablePackages else {
                    self.showErrorAlert(errorType: .noDiscountedOfferingsFound)
                    return
                }
                self.packages = allDiscountedBrassInstrumentsPackages
            case .allDiscountedWoodwindInstruments:
                guard let allDiscountedWoodwindInstrumentsPackages = availableOfferings?.offering(identifier:
                                                                                                    "all-discounted-woodwind-instruments")?.availablePackages else {
                    self.showErrorAlert(errorType: .noDiscountedOfferingsFound)
                    return
                }
                self.packages = allDiscountedWoodwindInstrumentsPackages
            case .woodwindsBrassDiscounted:
                guard let woodwindsBrassDiscounted = availableOfferings?.offering(identifier: "woodwinds-brass-discounted")?.availablePackages else {
                    self.showErrorAlert(errorType: .noDiscountedOfferingsFound)
                    return
                }
                self.packages = woodwindsBrassDiscounted
            case .woodwindsDiscounted:
                guard let woodwindsDiscountedPackages = availableOfferings?.offering(identifier: "woodwinds-discounted")?.availablePackages else {
                    self.showErrorAlert(errorType: .noDiscountedOfferingsFound)
                    return
                }
                self.packages = woodwindsDiscountedPackages
            case .brassDiscounted:
                guard let brassDiscountedPackages = availableOfferings?.offering(identifier: "brass-discounted")?.availablePackages else {
                    self.showErrorAlert(errorType: .noDiscountedOfferingsFound)
                    return
                }
                self.packages = brassDiscountedPackages
            case .current:
                guard let currentPackages = availableOfferings?.current?.availablePackages else {
                    self.showErrorAlert(errorType: .noCurrentOfferingsFound)
                    return
                }
                self.packages = currentPackages
            }
            
            if self.packages.isEmpty {
                if self.offeringType == .none {
                    if Configuration.appConfiguration == .testFlight {
                        self.showAlert(title: "Congratulations!", message: "You have access to all instruments as a TestFlight user!") { action in
                            self.dismiss(animated: true)
                        }
                    } else {
                        self.showAlert(title: "Congratulations!", message: "You have bought all instruments and have infinite access to them, including future additions!") { action in
                            self.dismiss(animated: true)
                        }
                    }
                } else {
                    self.showErrorAlert(errorType: .noPackagesFound)
                }
            }
            
            let freeGroup = self.chartsController.allInstrumentGroups[UserDefaults.standard.integer(forKey: UserDefaults.Keys.chosenFreeInstrumentGroupIndex)]
            
            for (index, package) in self.packages.enumerated() {
                if package.product.localizedTitle == freeGroup.groupTitle {
                    self.packages.remove(at: index)
                    break
                }
            }
            
            self.loadingIndicator.stopAnimating()
            self.collectionView.reloadData()
            self.closeButton.isEnabled = true
        }
    }
    
    private func showErrorAlert(errorType: PurchasesErrorType) {
        switch errorType {
        case .unableToFetchOfferings:
            showAlert(title: "Error", message: "Unable to fetch offerings") { action in
                self.dismiss(animated: true)
            }
        case .noCurrentOfferingsFound:
            showAlert(title: "Error", message: "No current offerings found") { action in
                self.dismiss(animated: true)
            }
        case .noDiscountedOfferingsFound:
            showAlert(title: "Error", message: "No discounted offerings found") { (action) in
                self.dismiss(animated: true)
            }
        case .noPackagesFound:
            showAlert(title: "Error", message: "No packages found") { (action) in
                self.dismiss(animated: true)
            }
        }
    }
    
    private func setOfferingType(purchaserInfo: Purchases.PurchaserInfo?) {
        if purchaserInfo?.entitlements["all"]?.isActive == true || Configuration.appConfiguration == .testFlight {
            offeringType = .none
        } else if (purchaserInfo?.entitlements["woodwinds"]?.isActive == true &&
                        (purchaserInfo?.entitlements["trumpet"]?.isActive == true ||
                        purchaserInfo?.entitlements["french_horn"]?.isActive == true ||
                        purchaserInfo?.entitlements["trombone"]?.isActive == true ||
                        purchaserInfo?.entitlements["euphonium"]?.isActive == true ||
                        purchaserInfo?.entitlements["tuba"]?.isActive == true)) ||
                    (purchaserInfo?.entitlements["brass"]?.isActive == true &&
                        (purchaserInfo?.entitlements["flute"]?.isActive == true ||
                        purchaserInfo?.entitlements["clarinet"]?.isActive == true ||
                        purchaserInfo?.entitlements["saxophone"]?.isActive == true)) {
            offeringType = .allDiscounted
        } else if purchaserInfo?.entitlements["woodwinds"]?.isActive == true {
            offeringType = .allDiscountedBrassInstruments
        } else if purchaserInfo?.entitlements["brass"]?.isActive == true {
            offeringType = .allDiscountedWoodwindInstruments
        } else if (purchaserInfo?.entitlements["flute"]?.isActive == true ||
                    purchaserInfo?.entitlements["clarinet"]?.isActive == true ||
                    purchaserInfo?.entitlements["saxophone"]?.isActive == true) &&
                    (purchaserInfo?.entitlements["trumpet"]?.isActive == true ||
                    purchaserInfo?.entitlements["french_horn"]?.isActive == true ||
                    purchaserInfo?.entitlements["trombone"]?.isActive == true ||
                    purchaserInfo?.entitlements["euphonium"]?.isActive == true ||
                    purchaserInfo?.entitlements["tuba"]?.isActive == true) {
            offeringType = .woodwindsBrassDiscounted
        } else if purchaserInfo?.entitlements["flute"]?.isActive == true ||
                    purchaserInfo?.entitlements["clarinet"]?.isActive == true ||
                    purchaserInfo?.entitlements["saxophone"]?.isActive == true {
            offeringType = .woodwindsDiscounted
        } else if purchaserInfo?.entitlements["trumpet"]?.isActive == true ||
                    purchaserInfo?.entitlements["french_horn"]?.isActive == true ||
                    purchaserInfo?.entitlements["trombone"]?.isActive == true ||
                    purchaserInfo?.entitlements["euphonium"]?.isActive == true ||
                    purchaserInfo?.entitlements["tuba"]?.isActive == true {
            offeringType = .brassDiscounted
        } else {
            offeringType = .current
        }
    }
    
    @objc private func continuePressed() {
        if let selectedIndex = selectedCellIndex {
            let index: Int
            
            switch selectedIndex.section {
            case 0:
                index = selectedIndex.row
            case 1:
                index = selectedIndex.row + 1
            case 2:
                if offeringType == .current || offeringType == .woodwindsDiscounted || offeringType == .brassDiscounted {
                    index = selectedIndex.row + 3
                } else {
                    index = selectedIndex.row + 1
                }
            default:
                fatalError("Section unexpected")
            }
            
            Purchases.shared.purchasePackage(packages[index]) { transaction, purchaserInfo, error, userCancelled in
                if userCancelled {
                    self.showAlert(title: "Purchase cancelled", message: nil) { (action) in
                        self.collectionView(self.collectionView, didSelectItemAt: self.selectedCellIndex!)
                    }
                    
                    return
                }
                
                self.chartsController.updatePurchasableInstrumentGroups(resetIndex: true)
                self.dismiss(animated: true)
            }
        } else {
            dismiss(animated: true)
        }
    }
}

extension PurchaseInstrumentsViewController: UICollectionViewDelegate {}

extension PurchaseInstrumentsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard packages.count != 0 else { return 0 }
        
        switch section {
        case 0:
            if offeringType != .none {
                return 1
            }
            return 0
        case 1:
            if offeringType == .current || offeringType == .woodwindsDiscounted || offeringType == .brassDiscounted || offeringType == .woodwindsBrassDiscounted {
                return 2
            }
            return 0
        case 2:
            if offeringType == .current || offeringType == .woodwindsDiscounted || offeringType == .brassDiscounted {
                return packages.count - 3
            } else if offeringType == .allDiscountedWoodwindInstruments || offeringType == .allDiscountedBrassInstruments {
                return packages.count - 1
            }
            return 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchaseInstrumentLargeCell.reuseIdentifier,
                                                                for: indexPath) as? PurchaseInstrumentLargeCell else { fatalError() }
            cell.purchasableInstrumentGroup = allPurchasableInstrumentGroup
            cell.package = packages[indexPath.item]
            cell.setupSubviews()
            
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchaseInstrumentSmallCell.reuseIdentifier,
                                                                for: indexPath) as? PurchaseInstrumentSmallCell else { fatalError() }
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
            
            return cell
        case 2:
            var purchasableGroups = chartsController.purchasableInstrumentGroups
            
            if offeringType == .woodwindsDiscounted || offeringType == .allDiscountedBrassInstruments {
                for (index, group) in purchasableGroups.enumerated().reversed() {
                    if group.groupTitle == "Flute" || group.groupTitle == "Clarinet" || group.groupTitle == "Saxophone" {
                        purchasableGroups.remove(at: index)
                    }
                }
            } else if offeringType == .brassDiscounted || offeringType == .allDiscountedWoodwindInstruments {
                for (index, group) in purchasableGroups.enumerated().reversed() {
                    if group.groupTitle == "Trumpet" ||
                        group.groupTitle == "French Horn" ||
                        group.groupTitle == "Trombone" ||
                        group.groupTitle == "Euphonium" ||
                        group.groupTitle == "Tuba" {
                        purchasableGroups.remove(at: index)
                    }
                }
            }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchaseInstrumentSmallCell.reuseIdentifier, for: indexPath) as? PurchaseInstrumentSmallCell else { fatalError() }
            cell.purchasableInstrumentGroup = purchasableGroups[indexPath.item]
            cell.package = packages[indexPath.item + (offeringType == .current || offeringType == .woodwindsDiscounted || offeringType == .brassDiscounted ? 3 : 1)]
            cell.setupSubviews()
            
            return cell
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PurchaseInstrumentCell else { fatalError() }
        
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

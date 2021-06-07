//
//  PurchaseInstrumentCell.swift
//  NOTEbook
//
//  Created by Matt Free on 6/7/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import Purchases
import UIKit

class PurchaseInstrumentCell: UICollectionViewCell {
    let instrumentTitleSize: CGFloat = 12
    
    var purchasableInstrumentGroup: PurchasableInstrumentGroup!
    var package: Purchases.Package!
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = package.localizedPriceString
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: instrumentTitleSize + 4)
        label.textColor = .notebookDarkAqua
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.tag = calculateDiscount()
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.01
        label.text = "SAVE\n\(calculateDiscount())%"
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: instrumentTitleSize - 2)
        label.textColor = .notebookMediumRed
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func setupSubviews() {
        backgroundColor = .notebookLightestAqua
        layer.cornerRadius = 20
        layer.borderColor = UIColor.notebookMediumRed.cgColor
        
        addSubview(priceLabel)
        addSubview(discountLabel)
        
        discountLabel.isHidden = discountLabel.tag == 0
        
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            discountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            discountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    private func calculateDiscount() -> Int {
        switch package.identifier {
        case "all":
            let purchasableGroups = ChartsController.shared.purchasableInstrumentGroups
            let instrumentPrice = UserDefaults.standard.double(forKey: UserDefaults.Keys.instrumentPrice)
            let allPrice = Double(truncating: package.product.price)
            
            let invertedFraction = allPrice / (instrumentPrice * Double(purchasableGroups.count))
            let fraction = 1 - invertedFraction
            let percentage = Int(ceil(fraction * 100))
            
            return percentage
        case "woodwinds", "brass":
            let purchasableGroups = ChartsController.shared.purchasableInstrumentGroups
            let instrumentPrice = UserDefaults.standard.double(forKey: UserDefaults.Keys.instrumentPrice)
            let groupPrice = Double(truncating: package.product.price)
            
            var groupPurchasableGroups = [PurchasableInstrumentGroup]()
            
            for group in purchasableGroups {
                if package.identifier == "woodwinds" && (group.groupTitle == "Flute" || group.groupTitle == "Clarinet" || group.groupTitle == "Saxophone") {
                    groupPurchasableGroups.append(group)
                } else if package.identifier == "brass" && (group.groupTitle == "Trumpet" || group.groupTitle == "French Horn" || group.groupTitle == "Trombone" || group.groupTitle == "Euphonium" || group.groupTitle == "Tuba") {
                    groupPurchasableGroups.append(group)
                }
            }
            
            return calculatePercentage(groupPrice: groupPrice, instrumentPrice: instrumentPrice, groupPurchasableGroupsCount: Double(groupPurchasableGroups.count))
        default:
            return 0
        }
    }
    
    private func calculatePercentage(groupPrice: Double, instrumentPrice: Double, groupPurchasableGroupsCount: Double) -> Int {
        let invertedFraction = groupPrice / (instrumentPrice * groupPurchasableGroupsCount)
        let fraction = 1 - invertedFraction
        let percentage = Int(ceil(fraction * 100))
        
        return percentage
    }
}

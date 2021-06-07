//
//  PurchaseInstrumentSmallCell.swift
//  NOTEbook
//
//  Created by Matt Free on 12/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Purchases
import UIKit

class PurchaseInstrumentSmallCell: UICollectionViewCell {
    static let reuseIdentifier = "PurchaseInstrumentSmallCell"
    
    private let instrumentTitleSize: CGFloat = 12
    
    var purchasableInstrumentGroup: PurchasableInstrumentGroup!
    var package: Purchases.Package!
    
    lazy var groupTitleLabel = PurchaseGroupTitleLabel(title: purchasableInstrumentGroup.groupTitle)
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(groupTitleLabel)
        addSubview(priceLabel)
        addSubview(discountLabel)
        
        discountLabel.isHidden = discountLabel.tag == 0
        
        NSLayoutConstraint.activate([
            groupTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            groupTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            groupTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            groupTitleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            discountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            discountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
        
        for (index, title) in purchasableInstrumentGroup.instrumentTitles.enumerated() {
            let instrumentTitleLabel = PurchaseInstrumentTitleLabel(title: title, fontSize: instrumentTitleSize)
            addSubview(instrumentTitleLabel)
            
            NSLayoutConstraint.activate([
                instrumentTitleLabel.topAnchor.constraint(equalTo: groupTitleLabel.bottomAnchor, constant: CGFloat(4 + (Int(instrumentTitleSize) + 4) * index)),
                instrumentTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                instrumentTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                instrumentTitleLabel.heightAnchor.constraint(equalToConstant: instrumentTitleSize)
            ])
        }
    }
    
    private func calculateDiscount() -> Int {
        switch package.identifier {
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
            
            let invertedFraction = groupPrice / (instrumentPrice * Double(groupPurchasableGroups.count))
            let fraction = 1 - invertedFraction
            let percentage = Int(ceil(fraction * 100))
            
            return percentage
        default:
            return 0
        }
    }
}

//
//  PurchaseInstrumentLargeCell.swift
//  NOTEbook
//
//  Created by Matt Free on 12/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Purchases
import UIKit

class PurchaseInstrumentLargeCell: UICollectionViewCell {
    static let reuseIdentifier = "PurchaseInstrumentLargeCell"
    
    private let instrumentTitleSize: CGFloat = 12
    
    var purchasableInstrumentGroup: PurchasableInstrumentGroup!
    var package: Purchases.Package!
    
    lazy var groupTitleLabel: UILabel = {
        let label = UILabel()
        label.text = purchasableInstrumentGroup.groupTitle
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .notebookDarkAqua
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = package.localizedPriceString
        label.textAlignment = .right
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
            groupTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            groupTitleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -10),
            groupTitleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            
            discountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            discountLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
        
        for (index, title) in purchasableInstrumentGroup.instrumentTitles.enumerated() {
            let instrumentTitleLabel = UILabel()
            instrumentTitleLabel.text = title
            instrumentTitleLabel.textAlignment = .natural
            instrumentTitleLabel.font = UIFont.systemFont(ofSize: instrumentTitleSize)
            instrumentTitleLabel.textColor = .notebookDarkAqua
            instrumentTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            addSubview(instrumentTitleLabel)
            
            if index < 5 {
                instrumentTitleLabel.topAnchor.constraint(equalTo: groupTitleLabel.bottomAnchor, constant: CGFloat(4 + (Int(instrumentTitleSize) + 4) * index)).isActive = true
                instrumentTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
                instrumentTitleLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -5).isActive = true
            } else {
                instrumentTitleLabel.topAnchor.constraint(equalTo: groupTitleLabel.bottomAnchor, constant: CGFloat(4 + (Int(instrumentTitleSize) + 4) * (index - 5))).isActive = true
                instrumentTitleLabel.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 5).isActive = true
                instrumentTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
            }
            
            instrumentTitleLabel.heightAnchor.constraint(equalToConstant: instrumentTitleSize).isActive = true
        }
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
        default:
            return 0
        }
    }
}

//
//  PurchaseInstrumentLargeCell.swift
//  NOTEbook
//
//  Created by Matt Free on 12/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class PurchaseInstrumentLargeCell: PurchaseInstrumentCell {
    static let reuseIdentifier = "PurchaseInstrumentLargeCell"
    
    lazy var groupTitleLabel = PurchaseGroupTitleLabel(title: purchasableInstrumentGroup.groupTitle, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        addSubview(groupTitleLabel)
        
        NSLayoutConstraint.activate([
            groupTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            groupTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            groupTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            groupTitleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        for (index, title) in purchasableInstrumentGroup.instrumentTitles.enumerated() {
            let instrumentTitleLabel = PurchaseInstrumentTitleLabel(title: title, fontSize: instrumentTitleSize)
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
}

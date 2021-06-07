//
//  SelectInstrumentCell.swift
//  NOTEbook
//
//  Created by Matt Free on 12/11/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class SelectInstrumentCell: UICollectionViewCell {
    static let reuseIdentifier = "SelectInstrumentCell"
    
    var purchasableInstrumentGroup: PurchasableInstrumentGroup!
    
    private let instrumentTitleSize: CGFloat = 12
    
    private lazy var groupTitleLabel = PurchaseGroupTitleLabel(title: purchasableInstrumentGroup.groupTitle)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        addSubview(groupTitleLabel)
        
        NSLayoutConstraint.activate([
            groupTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            groupTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            groupTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            groupTitleLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        for (index, title) in purchasableInstrumentGroup.instrumentTitles.enumerated() {
            let instrumentTitleLabel = PurchaseInstrumentTitleLabel(title: title, fontSize: instrumentTitleSize)
            addSubview(instrumentTitleLabel)
            
            NSLayoutConstraint.activate([
                instrumentTitleLabel.topAnchor.constraint(equalTo: groupTitleLabel.bottomAnchor,
                                                          constant: CGFloat(4 + (Int(instrumentTitleSize) + 4) * index)),
                instrumentTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                instrumentTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                instrumentTitleLabel.heightAnchor.constraint(equalToConstant: instrumentTitleSize)
            ])
        }
    }
}

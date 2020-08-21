//
//  TitleCell.swift
//  NOTEbook
//
//  Created by Matt Free on 8/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class TitleCell: UICollectionViewCell {
    static let reuseIdentifier = "TitleCell"
    
    lazy var titleLabel = InstrumentTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

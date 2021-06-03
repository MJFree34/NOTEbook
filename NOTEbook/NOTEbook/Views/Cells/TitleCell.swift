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
    
    private var cellDividerHeight: CGFloat = 2
    private var cellDividerInset: CGFloat = 100
    
    lazy var titleLabel = InstrumentTitleLabel()
    lazy var cellDivider: UIView = {
        let view = UIView()
        view.backgroundColor = .notebookMediumAqua
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(cellDivider)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            cellDivider.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            cellDivider.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            cellDivider.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cellDivider.heightAnchor.constraint(equalToConstant: cellDividerHeight)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

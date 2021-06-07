//
//  PurchaseGroupTitleLabel.swift
//  NOTEbook
//
//  Created by Matt Free on 6/6/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class PurchaseGroupTitleLabel: UILabel {
    init(title: String, alignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        
        text = title
        numberOfLines = 0
        textAlignment = alignment
        font = UIFont.boldSystemFont(ofSize: 18)
        textColor = .notebookDarkAqua
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

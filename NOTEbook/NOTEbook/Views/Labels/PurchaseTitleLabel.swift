//
//  PurchaseTitleLabel.swift
//  NOTEbook
//
//  Created by Matt Free on 6/6/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class PurchaseTitleLabel: UILabel {
    init(title: String) {
        super.init(frame: .zero)
        
        text = title
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title1)
        textColor = .notebookMediumRed
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

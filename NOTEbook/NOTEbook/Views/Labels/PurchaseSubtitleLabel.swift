//
//  PurchaseSubtitleLabel.swift
//  NOTEbook
//
//  Created by Matt Free on 6/6/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class PurchaseSubtitleLabel: UILabel {
    init(title: String) {
        super.init(frame: .zero)
        
        text = title
        numberOfLines = 0
        minimumScaleFactor = 0.01
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title3)
        textColor = .notebookDarkAqua
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

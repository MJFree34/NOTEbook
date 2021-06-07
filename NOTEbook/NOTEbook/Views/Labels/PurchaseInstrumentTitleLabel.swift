//
//  PurchaseInstrumentTitleLabel.swift
//  NOTEbook
//
//  Created by Matt Free on 6/6/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class PurchaseInstrumentTitleLabel: UILabel {
    init(title: String, fontSize: CGFloat) {
        super.init(frame: .zero)
        
        text = title
        textAlignment = .natural
        font = UIFont.systemFont(ofSize: fontSize)
        textColor = .notebookDarkAqua
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  InstrumentTitleLabel.swift
//  NOTEbook
//
//  Created by Matt Free on 8/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class InstrumentTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = UIFont.preferredFont(forTextStyle: .title3)
        textAlignment = .center
        textColor = UIColor(named: "MediumAqua")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

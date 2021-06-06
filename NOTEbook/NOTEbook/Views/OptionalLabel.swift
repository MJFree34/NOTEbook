//
//  OptionalLabel.swift
//  NOTEbook
//
//  Created by Matt Free on 6/5/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class OptionalLabel: UILabel {
    init(large: Bool) {
        super.init(frame: .zero)
        
        font = UIFont.preferredFont(forTextStyle: large ? .title1 : .title3)
        textAlignment = .center
        textColor = .notebookBlack
        isHidden = true
        text = "N/A"
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

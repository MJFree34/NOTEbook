//
//  FingeringKeyView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/3/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class FingeringKeyView: UIImageView {
    init(imageName: String, ratio: CGFloat) {
        super.init(image: UIImage(named: imageName)!.withTintColor(.notebookBlack))
        
        transform = CGAffineTransform(scaleX: ratio, y: ratio)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ArrowImageView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/6/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class ArrowImageView: UIImageView {
    init(left: Bool) {
        super.init(image: UIImage(named: UIImage.Assets.swipeArrow)!.withTintColor(.notebookBlack))
        
        if left {
            transform = CGAffineTransform(rotationAngle: .pi)
        }
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

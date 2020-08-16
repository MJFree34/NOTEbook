//
//  FingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FingeringView: UIView {
    let fingering: Fingering
    let ratio: CGFloat
    
    init(fingering: Fingering, ratio: CGFloat) {
        self.fingering = fingering
        self.ratio = ratio
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

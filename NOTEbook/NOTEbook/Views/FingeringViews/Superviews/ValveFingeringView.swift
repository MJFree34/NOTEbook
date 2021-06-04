//
//  ValveFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/3/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class ValveFingeringView: FingeringView {
    lazy var finger1 = FingeringKeyView(imageName: fingering.keys![0] ? UIImage.Instruments.Round.full1 : UIImage.Instruments.Round.empty1, ratio: ratio)
    lazy var finger2 = FingeringKeyView(imageName: fingering.keys![1] ? UIImage.Instruments.Round.full2 : UIImage.Instruments.Round.empty2, ratio: ratio)
    lazy var finger3 = FingeringKeyView(imageName: fingering.keys![2] ? UIImage.Instruments.Round.full3 : UIImage.Instruments.Round.empty3, ratio: ratio)
    lazy var finger4 = FingeringKeyView(imageName: fingering.keys![3] ? UIImage.Instruments.Round.full4 : UIImage.Instruments.Round.empty4, ratio: ratio)
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

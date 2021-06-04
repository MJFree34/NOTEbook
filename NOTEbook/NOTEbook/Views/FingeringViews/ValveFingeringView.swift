//
//  ValveFingeringView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/3/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class ValveFingeringView: FingeringView {
    lazy var finger1: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![0] ? UIImage.Instruments.Round.full1 : UIImage.Instruments.Round.empty1))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var finger2: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![1] ? UIImage.Instruments.Round.full2 : UIImage.Instruments.Round.empty2))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var finger3: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![2] ? UIImage.Instruments.Round.full3 : UIImage.Instruments.Round.empty3))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var finger4: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: (fingering.keys![2] ? UIImage.Instruments.Round.full3 : UIImage.Instruments.Round.empty3))!.withTintColor(.notebookBlack))
        imageView.transform = CGAffineTransform(scaleX: ratio, y: ratio)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(fingering: Fingering, ratio: CGFloat) {
        super.init(fingering: fingering, ratio: ratio)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  StaffView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/6/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class StaffView: UIView {
    lazy var trebleClefImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TrebleClef")!.withTintColor(UIColor(named: "Black")!))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        
        return imageView
    }()
    
    lazy var bassClefImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "BassClef")!.withTintColor(UIColor(named: "Black")!))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        
        return imageView
    }()
    
    init(width: CGFloat) {
        super.init(frame: .zero)
        
        addLines(width: width)
        addClefs()
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLines(width: CGFloat) {
        for i in 0..<5 {
            addStaffLine(bottomInset: NotePickerViewController.spaceBetweenStaffLines * (4 - CGFloat(i)), width: width)
        }
    }
    
    func addClefs() {
        addSubview(trebleClefImageView)
        addSubview(bassClefImageView)
        
        NSLayoutConstraint.activate([
            trebleClefImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -5),
            trebleClefImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -2),
            
            bassClefImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -5),
            bassClefImageView.topAnchor.constraint(equalTo: topAnchor, constant: -0.5)
        ])
    }
    
    func addStaffLine(bottomInset: CGFloat, width: CGFloat) {
        let staffImageView = UIImageView(image: UIImage.drawStaffLine(color: .black, size: CGSize(width: width, height: 2), rounded: true).withTintColor(UIColor(named: "Black")!))
        staffImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(staffImageView)
        
        NSLayoutConstraint.activate([
            staffImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomInset),
            staffImageView.heightAnchor.constraint(equalToConstant: 2),
            staffImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func updateClef(with clef: Clef) {
        switch clef {
        case .bass:
            trebleClefImageView.isHidden = true
            bassClefImageView.isHidden = false
        case .treble:
            trebleClefImageView.isHidden = false
            bassClefImageView.isHidden = true
        }
    }
}

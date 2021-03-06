//
//  StaffView.swift
//  NOTEbook
//
//  Created by Matt Free on 8/6/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class StaffView: UIView {
    private lazy var trebleClefImageView = ClefImageView(clef: .treble, transformScale: NotePickerViewController.spaceBetweenStaffLines / 20)
    private lazy var bassClefImageView = ClefImageView(clef: .bass, transformScale: NotePickerViewController.spaceBetweenStaffLines / 20)
    
    init(width: CGFloat) {
        super.init(frame: .zero)
        
        addLines(width: width)
        addClefs()
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLines(width: CGFloat) {
        for i in 0..<5 {
            addStaffLine(bottomInset: NotePickerViewController.spaceBetweenStaffLines * (4 - CGFloat(i)), width: width)
        }
    }
    
    private func addClefs() {
        addSubview(trebleClefImageView)
        addSubview(bassClefImageView)
        
        NSLayoutConstraint.activate([
            trebleClefImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -2),
            trebleClefImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -2 * NotePickerViewController.spaceBetweenStaffLines / 20),
            
            bassClefImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -2),
            bassClefImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -9.75 * NotePickerViewController.spaceBetweenStaffLines / 20)
        ])
    }
    
    private func addStaffLine(bottomInset: CGFloat, width: CGFloat) {
        let staffImageView = UIImageView(image: UIImage.drawStaffLine(color: .notebookBlack,
                                                                      size: CGSize(width: width, height: 2),
                                                                      rounded: true).withTintColor(.notebookBlack))
        staffImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(staffImageView)
        
        NSLayoutConstraint.activate([
            staffImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bottomInset),
            staffImageView.heightAnchor.constraint(equalToConstant: 2),
            staffImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
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

//
//  TutorialCell.swift
//  NOTEbook
//
//  Created by Matt Free on 7/10/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class TutorialCell: UITableViewCell {
    static let reuseIdentifier = "TutorialCell"
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor(named: "DarkAqua")
        label.text = "Filler"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tutorialImage: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        return imgView
    }()
    
    lazy var imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tutorialImage)
        
        NSLayoutConstraint.activate([
            tutorialImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tutorialImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tutorialImage.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -20),
            tutorialImage.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20)
        ])
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        contentView.addSubview(imageContainer)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageContainer.widthAnchor.constraint(equalToConstant: 150),
            
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageContainer.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with info: TutorialInfo) {
        descriptionLabel.text = info.description
        
        if info.imageName == "gear" {
            tutorialImage.image = UIImage(systemName: info.imageName)
            tutorialImage.tintColor = UIColor(named: "DarkAqua")
        } else if info.imageName == "LargeInstrumentsButton" {
            tutorialImage.image = UIImage(named: info.imageName)?.withRenderingMode(.alwaysTemplate)
            tutorialImage.tintColor = UIColor(named: "DarkAqua")
        } else {
            tutorialImage.image = UIImage(named: info.imageName)
            tutorialImage.tintColor = .clear
        }
    }
}

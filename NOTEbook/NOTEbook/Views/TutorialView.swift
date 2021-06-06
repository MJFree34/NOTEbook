//
//  TutorialView.swift
//  NOTEbook
//
//  Created by Matt Free on 11/22/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class TutorialView: UIView {
    private let tutorialInformation = [
        ["title" : "Welcome!",
         "imageType" : "png",
         "imageName" : UIImage.Assets.appIcon200x200,
         "description" : "Welcome to NOTEbook:  your one source for comprehensive fingering charts!"],
        ["title" : "Pick any note",
         "imageType" : "gif",
         "imageName" : UIImage.TutorialGifs.notePicker,
         "description" : "Swipe through the custom note picker to select any note"],
        ["title" : "Choose an alternate fingering",
         "imageType" : "gif",
         "imageName" : UIImage.TutorialGifs.alternateFingerings,
         "description" : "Swipe through alternate fingerings to find the perfect one for your need\n(tip: you can set a fingering limit in settings)"],
        ["title" : "Select an accidental",
         "imageType" : "gif",
         "imageName" : UIImage.TutorialGifs.accidentals,
         "description" : "Swipe left or right to cycle through accidentals"],
        ["title" : "Use the chart",
         "imageType" : "gif",
         "imageName" : UIImage.TutorialGifs.chart,
         "description" : "See the notes in chromatic context along with their fingerings\n(tip: common on top to least common on bottom)"],
        ["title" : "Try all instruments",
         "imageType" : "gif",
         "imageName" : UIImage.TutorialGifs.instruments,
         "description" : "14-day free trial for all 10 instrument groups, after which you will select one group to have free forever!"],
        ["title" : "Get started!",
         "imageType" : "png",
         "imageName" : UIImage.Assets.getStartedIcons,
         "description" : "Customize this app to your needs in settings and enjoy!"]
    ]
    
    private let compromiseLightestestAqua = UIColor(red: 237 / 255, green: 1, blue: 253 / 255, alpha: 1)
    private let compromiseDarkestestAqua = UIColor(red: 15 / 255, green: 81 / 255, blue: 79 / 255, alpha: 1)
    
    private lazy var pageControl: NotebookPageControl = {
        let control = NotebookPageControl(pages: tutorialInformation.count)
        control.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        return control
    }()
    
    private lazy var scrollView: NotebookScrollView = {
        let sv = NotebookScrollView()
        sv.delegate = self
        return sv
    }()
    
    private lazy var continueButton: ContinueButton = {
        let button = ContinueButton(title: "Get started!",
                                    normalTitleColor: traitCollection.userInterfaceStyle == UIUserInterfaceStyle.light ? compromiseLightestestAqua : compromiseDarkestestAqua)
        button.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
        return button
    }()
    
    var pageIndex: Int {
        return pageControl.currentPage
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(scrollView)
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        // Colors that match the light and dark colors of the gifs
        backgroundColor = (traitCollection.userInterfaceStyle == UIUserInterfaceStyle.light ? compromiseLightestestAqua : compromiseDarkestestAqua)
        layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTutorialPages() {
        pageControlValueChanged(to: 0, animated: false)
        
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(tutorialInformation.count), height: frame.size.height)
        
        for (index, information) in tutorialInformation.enumerated() {
            let tutorialPage = UIView()
            tutorialPage.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(tutorialPage)
            
            NSLayoutConstraint.activate([
                tutorialPage.widthAnchor.constraint(equalToConstant: frame.size.width),
                tutorialPage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: frame.size.width * CGFloat(index)),
                tutorialPage.topAnchor.constraint(equalTo: scrollView.topAnchor),
                tutorialPage.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
            let stackView = UIStackView(arrangedSubviews: createSubviews(information: information))
            stackView.alignment = .center
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            tutorialPage.addSubview(stackView)
            
            if index == tutorialInformation.count - 1 {
                tutorialPage.addSubview(continueButton)
                
                NSLayoutConstraint.activate([
                    stackView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: 10),
                    
                    continueButton.bottomAnchor.constraint(equalTo: tutorialPage.bottomAnchor, constant: -30),
                    continueButton.leadingAnchor.constraint(equalTo: tutorialPage.leadingAnchor, constant: 10),
                    continueButton.trailingAnchor.constraint(equalTo: tutorialPage.trailingAnchor, constant: -10),
                    continueButton.heightAnchor.constraint(equalToConstant: 44)
                ])
            } else {
                stackView.bottomAnchor.constraint(equalTo: tutorialPage.bottomAnchor, constant: -30).isActive = true
            }
            
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: tutorialPage.topAnchor, constant: 10),
                stackView.leadingAnchor.constraint(equalTo: tutorialPage.leadingAnchor, constant: 10),
                stackView.trailingAnchor.constraint(equalTo: tutorialPage.trailingAnchor, constant: -10)
            ])
        }
    }
    
    func select(index: Int) {
        pageControlValueChanged(to: index, animated: false)
    }
    
    private func createSubviews(information: [String : String]) -> [UIView] {
        let titleLabel = UILabel()
        titleLabel.text = information["title"]
        titleLabel.textColor = .notebookMediumRed
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        if information["imageType"]! == "gif" {
            let imageData = try? Data(contentsOf: Bundle.main.url(forResource: information["imageName"]! + (traitCollection.userInterfaceStyle == UIUserInterfaceStyle.light ? "Light" : "Dark"), withExtension: "gif")!)
            let gifImage = UIImage.gifImageWithData(imageData!)!
            
            imageView.image = gifImage
        } else {
            imageView.image = UIImage(named: information["imageName"]!)
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.text = information["description"]
        descriptionLabel.textColor = .notebookDarkAqua
        descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        return [titleLabel, imageView, descriptionLabel]
    }
    
    @objc private func continuePressed() {
        NotificationCenter.default.post(name: .tutorialDismissed, object: nil)
    }
    
    @objc private func pageControlChanged(sender: UIPageControl) {
        pageControlValueChanged(to: sender.currentPage)
    }
    
    private func pageControlValueChanged(to value: Int, animated: Bool = true) {
        pageControl.currentPage = value
        scrollView.setContentOffset(CGPoint(x: frame.size.width * CGFloat(value), y: 0), animated: animated)
    }
}

extension TutorialView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.size.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

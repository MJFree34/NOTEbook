//
//  TutorialView.swift
//  NOTEbook
//
//  Created by Matt Free on 11/22/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class TutorialView: UIView {
    private let tutorialInformation = [["title" : "Welcome!", "imageType" : "png", "imageName" : "AppIcon200x200", "description" : "Welcome to NOTEbook, your one source for comprehensive fingering charts.  This tutorial will show you the gestures to make the most out of this resource for all musicians"], ["title" : "Pick any note", "imageType" : "gif", "imageName" : "NotePickerFinal", "description" : "Swipe through the custom note picker to select the note for which you wish to see the fingering"], ["title" : "Choose an alternate fingering", "imageType" : "gif", "imageName" : "AlternateFingeringsFinal", "description" : "Swipe through the expansive database of fingerings to find the perfect one for your need"], ["title" : "Select an accidental", "imageType" : "gif", "imageName" : "AccidentalsFinal", "description" : "Swipe left or right to switch accidentals"], ["title" : "Use the chart", "imageType" : "gif", "imageName" : "ChartFinal", "description" : "See the notes chromatically with all alternate fingerings visible in order of commonality"], ["title" : "Try all instruments", "imageType" : "gif", "imageName" : "InstrumentsFinal", "description" : "View any of 10 instrument groups for a 14-day period, after which you will have one group for free forever!"], ["title" : "Get started!", "imageType" : "png", "imageName" : "GetStartedIcons", "description" : "Customize this app for your needs in settings and enjoy!"]]
    
    private let compromiseLightestestAqua = UIColor(red: 237 / 255, green: 1, blue: 253 / 255, alpha: 1)
    private let compromiseDarkestestAqua = UIColor(red: 15 / 255, green: 81 / 255, blue: 79 / 255, alpha: 1)
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.currentPageIndicatorTintColor = UIColor(named: "Black")!
        control.pageIndicatorTintColor = UIColor(named: "LightAqua")!
        control.addTarget(self, action: #selector(pageControlChanged), for: .valueChanged)
        control.numberOfPages = tutorialInformation.count
        control.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 14.0, *) {
            control.allowsContinuousInteraction = false
        }
        
        return control
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.isPagingEnabled = true
        sv.bounces = false
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.delegate = self
        sv.translatesAutoresizingMaskIntoConstraints = false
        
        return sv
    }()
    
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
            
            // Subviews
            let titleLabel = UILabel()
            titleLabel.text = information["title"]
            titleLabel.textColor = UIColor(named: "MediumRed")
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
            descriptionLabel.textColor = UIColor(named: "DarkAqua")
            descriptionLabel.font = UIFont.preferredFont(forTextStyle: .body)
            descriptionLabel.textAlignment = .center
            descriptionLabel.numberOfLines = 0
            
            // Adding subviews into stackView
            let stackView = UIStackView(arrangedSubviews: [titleLabel, imageView, descriptionLabel])
            stackView.alignment = .center
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            tutorialPage.addSubview(stackView)
            
            if index == tutorialInformation.count - 1 {
                let exitButton = UIButton(type: .custom)
                exitButton.setTitle("Get started!", for: .normal)
                exitButton.setTitleColor((traitCollection.userInterfaceStyle == UIUserInterfaceStyle.light ? compromiseLightestestAqua : compromiseDarkestestAqua), for: .normal)
                exitButton.backgroundColor = UIColor(named: "DarkAqua")
                exitButton.layer.cornerRadius = 10
                exitButton.addTarget(self, action: #selector(tutorialDismissed), for: .touchUpInside)
                exitButton.translatesAutoresizingMaskIntoConstraints = false
                tutorialPage.addSubview(exitButton)
                
                NSLayoutConstraint.activate([
                    stackView.bottomAnchor.constraint(equalTo: exitButton.topAnchor, constant: 10),
                    
                    exitButton.bottomAnchor.constraint(equalTo: tutorialPage.bottomAnchor, constant: -30),
                    exitButton.leadingAnchor.constraint(equalTo: tutorialPage.leadingAnchor, constant: 10),
                    exitButton.trailingAnchor.constraint(equalTo: tutorialPage.trailingAnchor, constant: -10),
                    exitButton.heightAnchor.constraint(equalToConstant: 44)
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
    
    @objc private func tutorialDismissed() {
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
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.size.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

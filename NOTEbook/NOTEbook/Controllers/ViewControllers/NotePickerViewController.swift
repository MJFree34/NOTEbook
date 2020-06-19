//
//  ViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NotePickerViewController: UIViewController {
    var chartsController = ChartsController.shared
    
    var currentNoteType: NoteType = .natural
    
    lazy var rightArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "SwipeArrow"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var leftArrow: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "SwipeArrow"))
        imageView.transform = CGAffineTransform(rotationAngle: .pi)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrowFlat: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Flat"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrowSharp: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Sharp"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var leftArrowNatural: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Natural"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var rightArrowNatural: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Natural"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addBackgroundGradient()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changeNoteType))
        swipeLeft.numberOfTouchesRequired = 1
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changeNoteType))
        swipeRight.numberOfTouchesRequired = 1
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
        
        configureHeader()
        configureSwipeArrows()
    }
    
    func configureHeader() {
        let settingsImageConfiguration = UIImage.SymbolConfiguration(pointSize: 50, weight: .heavy)
        let settingsImage = UIImage(systemName: "gear", withConfiguration: settingsImageConfiguration)!
        let settingsButton = UIButton(type: .custom)
        settingsButton.setImage(settingsImage.withTintColor(UIColor(named: "DarkAqua")!, renderingMode: .alwaysOriginal), for: .normal)
        settingsButton.setImage(settingsImage.withTintColor(UIColor(named: "LightAqua")!, renderingMode: .alwaysOriginal), for: .highlighted)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsButton)
        
        let gridButtonImage = UIImage(named: "GridButton")!
        let gridButtonPressedImage = UIImage(named: "PressedGridButton")!
        let gridButton = UIButton(type: .custom)
        gridButton.setImage(gridButtonImage, for: .normal)
        gridButton.setImage(gridButtonPressedImage, for: .highlighted)
        gridButton.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gridButton)
        
        let instrumentsButtonImage = UIImage(named: "InstrumentsButton")!
        let instrumentsButton = UIButton(type: .custom)
        instrumentsButton.setImage(instrumentsButtonImage, for: .normal)
        instrumentsButton.setImage(instrumentsButtonImage.withTintColor(UIColor(named: "LightAqua")!, renderingMode: .alwaysOriginal), for: .highlighted)
        instrumentsButton.addTarget(self, action: #selector(instrumentsButtonTapped), for: .touchUpInside)
        instrumentsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instrumentsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            settingsButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 50),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            
            gridButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            gridButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            gridButton.heightAnchor.constraint(equalToConstant: 50),
            gridButton.widthAnchor.constraint(equalToConstant: 50),
            
            instrumentsButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            instrumentsButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            instrumentsButton.widthAnchor.constraint(equalToConstant: 50),
            instrumentsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureSwipeArrows() {
        let topInset: CGFloat = 0.5457589286 * view.bounds.height
        
        view.addSubview(rightArrow)
        view.addSubview(rightArrowNatural)
        view.addSubview(arrowSharp)
        view.addSubview(leftArrow)
        view.addSubview(leftArrowNatural)
        view.addSubview(arrowFlat)
        
        rightArrowNatural.alpha = 0
        leftArrowNatural.alpha = 0
        
        NSLayoutConstraint.activate([
            rightArrow.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            rightArrow.topAnchor.constraint(equalTo: view.topAnchor, constant: topInset),
            
            rightArrowNatural.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -5),
            rightArrowNatural.centerYAnchor.constraint(equalTo: rightArrow.centerYAnchor),
            
            arrowSharp.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor, constant: -5),
            arrowSharp.centerYAnchor.constraint(equalTo: rightArrow.centerYAnchor),
            
            leftArrow.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            leftArrow.topAnchor.constraint(equalTo: view.topAnchor, constant: topInset),
            
            leftArrowNatural.leadingAnchor.constraint(equalTo: leftArrow.trailingAnchor, constant: 5),
            leftArrowNatural.centerYAnchor.constraint(equalTo: leftArrow.centerYAnchor),
            
            arrowFlat.leadingAnchor.constraint(equalTo: leftArrow.trailingAnchor, constant: 5),
            arrowFlat.centerYAnchor.constraint(equalTo: leftArrow.centerYAnchor)
        ])
    }
    
    @objc func changeNoteType(swipe: UISwipeGestureRecognizer) {
        let swipeDirection = swipe.direction
        
        if swipeDirection == .left {
            if currentNoteType == .natural {
                currentNoteType = .sharp
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrowFlat.alpha = 0
                    self.rightArrow.alpha = 0
                    self.arrowSharp.alpha = 0
                    self.leftArrowNatural.alpha = 1
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            } else if currentNoteType == .flat {
                currentNoteType = .natural
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.rightArrowNatural.alpha = 0
                    self.arrowSharp.alpha = 1
                    self.leftArrow.alpha = 1
                    self.arrowFlat.alpha = 1
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            }
        } else {
            if currentNoteType == .natural {
                currentNoteType = .flat
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.arrowFlat.alpha = 0
                    self.leftArrow.alpha = 0
                    self.arrowSharp.alpha = 0
                    self.rightArrowNatural.alpha = 1
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            } else if currentNoteType == .sharp {
                currentNoteType = .natural
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.leftArrowNatural.alpha = 0
                    self.arrowFlat.alpha = 1
                    self.rightArrow.alpha = 1
                    self.arrowSharp.alpha = 1
                    self.view.isUserInteractionEnabled = false
                }) { _ in
                    self.view.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    @objc func settingsButtonTapped() {
        // TODO: - Settings
    }
    
    @objc func instrumentsButtonTapped() {
        // TODO: - Instruments
    }
    
    @objc func gridButtonTapped() {
        let vc = NoteChartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

#if DEBUG
import SwiftUI

struct NotePickerViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return NotePickerViewController().view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        // Update your code here
    }
}

@available(iOS 13.0, *)
struct NotePickerViewController_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            NotePickerViewRepresentable()
                .previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
                .previewDisplayName("iPhone XS Max")
            
            NotePickerViewRepresentable()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
                .previewDisplayName("iPhone SE")
        }
    }
}
#endif

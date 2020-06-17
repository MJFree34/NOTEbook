//
//  NoteChartViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NoteChartViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addBackgroundGradient()
        
        let settingsImageConfiguration = UIImage.SymbolConfiguration(pointSize: 50, weight: .heavy)
        let settingsImage = UIImage(systemName: "gear", withConfiguration: settingsImageConfiguration)!
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(settingsImage.withTintColor(UIColor(named: "DarkAqua")!, renderingMode: .alwaysOriginal), for: .normal)
        settingsButton.setImage(settingsImage.withTintColor(UIColor(named: "LightAqua")!, renderingMode: .alwaysOriginal), for: .highlighted)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsButton)
        
        let pickerButtonImage = UIImage(named: "PickerButton")!
        let pickerButtonPressedImage = UIImage(named: "PressedPickerButton")!
        let pickerButton = UIButton(type: .custom)
        pickerButton.setImage(pickerButtonImage, for: .normal)
        pickerButton.setImage(pickerButtonPressedImage, for: .highlighted)
        pickerButton.addTarget(self, action: #selector(pickerButtonTapped), for: .touchUpInside)
        pickerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerButton)
        
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
            
            pickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            pickerButton.heightAnchor.constraint(equalToConstant: 50),
            pickerButton.widthAnchor.constraint(equalToConstant: 50),
            
            instrumentsButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            instrumentsButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            instrumentsButton.widthAnchor.constraint(equalToConstant: 50),
            instrumentsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc func settingsButtonTapped() {
        // TODO: - Settings
    }
    
    @objc func instrumentsButtonTapped() {
        // TODO: - Instruments
    }
    
    @objc func pickerButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

#if DEBUG
import SwiftUI

struct NoteChartViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return NoteChartViewController().view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        // Update your code here
    }
}

@available(iOS 13.0, *)
struct NoteChartViewController_Preview: PreviewProvider {
    static var previews: some View {
        NoteChartViewRepresentable()
    }
}
#endif

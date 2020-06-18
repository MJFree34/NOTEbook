//
//  ViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NotePickerViewController: UIViewController {
    var charts = [FingeringChart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let chartsURL = Bundle.main.url(forResource: "Charts", withExtension: "json") {
            if let data = try? Data(contentsOf: chartsURL) {
                let decoder = JSONDecoder()
                
                do {
                    charts = try decoder.decode([FingeringChart].self, from: data)
                } catch {
                    print(error.localizedDescription, error)
                }
            }
        }
        
        view.addBackgroundGradient()
        
        setupHeader()
    }
    
    func setupHeader() {
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

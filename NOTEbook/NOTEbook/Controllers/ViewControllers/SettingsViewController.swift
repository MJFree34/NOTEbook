//
//  SettingsViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 7/2/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var backButtonCenterYAnchor: NSLayoutAnchor<NSLayoutYAxisAnchor>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        view.addBackgroundGradient()
        
        addBackButton()
        addTitleLabel()
    }
    
    func addBackButton() {
        let backImage = UIImage(named: "BackButton")!
        
        let backButton = UIButton(type: .custom)
        backButton.setImage(backImage.withTintColor(UIColor(named: "DarkAqua")!), for: .normal)
        backButton.setImage(backImage.withTintColor(UIColor(named: "LightAqua")!), for: .highlighted)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        backButtonCenterYAnchor = backButton.centerYAnchor
    }
    
    func addTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = "Settings"
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.textColor = UIColor(named: "DarkAqua")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backButtonCenterYAnchor)
        ])
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

#if DEBUG
import SwiftUI

struct SettingsViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return SettingsViewController().view
    }
    
    func updateUIView(_ view: UIView, context: Context) {
        // Update your code here
    }
}

struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsViewRepresentable()
                .previewDisplayName("iPhone 11 Pro Max")
                .previewDevice("iPhone 11 Pro Max")
            SettingsViewRepresentable()
                .previewDisplayName("iPhone SE (2nd generation)")
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
#endif

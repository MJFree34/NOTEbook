//
//  SettingsViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 7/2/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        view.addBackgroundGradient()
        
        title = "Settings"
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

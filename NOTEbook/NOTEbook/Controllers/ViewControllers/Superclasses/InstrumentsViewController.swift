//
//  InstrumentsViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/7/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class InstrumentsViewController: UIViewController {
    var chartsController = ChartsController.shared
    var selectedIndex: IndexPath!
    
    @objc
    func shopPressed() {
        ChartsController.shared.updatePurchasableInstrumentGroups()
        let vc = PurchaseInstrumentsViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addBackground()
        
        let freeTrialOver = UserDefaults.standard.bool(forKey: UserDefaults.Keys.freeTrialOver)
        if freeTrialOver || Configuration.appConfiguration == .testFlight {
            let configuration = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .title3))
            let shopImage = UIImage(systemName: "dollarsign.circle",  withConfiguration: configuration)
            let shopBarButtonItem = UIBarButtonItem(image: shopImage, style: .plain, target: self, action: #selector(shopPressed))
            navigationItem.rightBarButtonItem = shopBarButtonItem
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackground()
    }
}

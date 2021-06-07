//
//  PurchaseViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/7/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class PurchaseViewController: UIViewController {
    let chartsController = ChartsController.shared
    
    var selectedCellIndex: IndexPath?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addBackground()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackground()
    }
}

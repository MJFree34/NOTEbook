//
//  ChartCollectionView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/5/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class ChartCollectionView: UICollectionView {
    init(reuseIdentifiers: [String]) {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        alwaysBounceVertical = false
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        
        for identifer in reuseIdentifiers {
            switch identifer {
            case SelectInstrumentCell.reuseIdentifier:
                register(SelectInstrumentCell.self, forCellWithReuseIdentifier: identifer)
            case NoteChartCell.reuseIdentifier:
                register(NoteChartCell.self, forCellWithReuseIdentifier: identifer)
            case PurchaseInstrumentSmallCell.reuseIdentifier:
                register(PurchaseInstrumentSmallCell.self, forCellWithReuseIdentifier: identifer)
            case PurchaseInstrumentLargeCell.reuseIdentifier:
                register(PurchaseInstrumentLargeCell.self, forCellWithReuseIdentifier: identifer)
            default:
                fatalError("Reuse identifier not found")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

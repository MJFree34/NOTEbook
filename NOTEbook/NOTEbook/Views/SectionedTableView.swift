//
//  SectionedTableView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/7/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class SectionedTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .insetGrouped)
        
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        estimatedRowHeight = 60
        register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

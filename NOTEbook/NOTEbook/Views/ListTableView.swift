//
//  ListTableView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/7/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class ListTableView: UITableView {
    init() {
        super.init(frame: .zero, style: .plain)
        
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        estimatedRowHeight = 100
        register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

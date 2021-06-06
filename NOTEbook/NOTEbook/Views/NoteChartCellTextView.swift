//
//  NoteChartCellTextView.swift
//  NOTEbook
//
//  Created by Matt Free on 6/5/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class NoteChartCellTextView: UITextView {
    init(alignment: NSTextAlignment) {
        super.init(frame: .zero, textContainer: nil)
        
        font = UIFont.systemFont(ofSize: 34)
        textAlignment = alignment
        backgroundColor = .clear
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

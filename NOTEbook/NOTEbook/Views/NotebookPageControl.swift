//
//  NotebookPageControl.swift
//  NOTEbook
//
//  Created by Matt Free on 6/6/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import UIKit

class NotebookPageControl: UIPageControl {
    init(pages: Int) {
        super.init(frame: .zero)
        
        currentPageIndicatorTintColor = .notebookBlack
        pageIndicatorTintColor = .notebookLightAqua
        numberOfPages = pages
        currentPage = 0
        translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 14.0, *) {
            allowsContinuousInteraction = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  CategoriesListViewState.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 7/22/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import Foundation

struct CategoriesListViewState {
    enum ScreenState: Equatable {
        case error(ChartError)
        case loaded
        case loading
    }

    var screenState: ScreenState = .loading
    var chartCategories = ChartCategories()

    let chartsURL = URL.documentsDirectory.appendingPathComponent("\(Constants.chartsFilename).json")
}

extension CategoriesListViewState {
    static func previewViewState(screenState: ScreenState = .loaded) -> CategoriesListViewState {
        CategoriesListViewState(screenState: screenState, chartCategories: .placeholder)
    }
}

//
//  ChartsController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/18/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

class ChartsController {
    static let shared = ChartsController()
    
    private var charts = [FingeringChart]()
    
    var currentChart: FingeringChart
    
    init() {
        do {
            charts = try ChartsLoader.loadCharts()
        } catch {
            fatalError("Fail to load charts")
        }
        
        currentChart = charts[0]
    }
}

extension ChartsController {
    var numberOfNoteFingeringsInCurrentChart: Int {
        return currentChart.noteFingerings.count
    }
    
    func chart(at index: Int) -> FingeringChart {
        return charts[index]
    }
}

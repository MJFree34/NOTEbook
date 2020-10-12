//
//  ChartTests.swift
//  NOTEbookTests
//
//  Created by Matt Free on 10/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import XCTest
@testable import NOTEbook

class ChartTests: XCTestCase {
    var chartController = ChartsController()
    
    func testNaturalFlatSharpNoteAmountsAreConsistent() {
        for chartCategory in chartController.chartCategories {
            for chart in chartCategory.fingeringCharts {
                let naturalNotesCount = chart.naturalNotes.count
                let flatNotesCount = chart.flatNotes.count
                let sharpNotesCount = chart.sharpNotes.count
                
                XCTAssertTrue(naturalNotesCount == flatNotesCount && naturalNotesCount == sharpNotesCount, "Instrument: \(chart.instrument.type.rawValue)")
            }
        }
    }
}

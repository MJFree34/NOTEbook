//
//  FingeringTests.swift
//  NOTEbookTests
//
//  Created by Matt Free on 10/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import XCTest
@testable import NOTEbook

class FingeringTests: XCTestCase {
    var chartsController = ChartsController()
    
    func testFluteFingering() {
        let fluteChartCategory = chartsController.chartCategories[0]
        
        for fluteChart in fluteChartCategory.fingeringCharts {
            for fluteNoteFingering in fluteChart.noteFingerings {
                for fluteFingering in fluteNoteFingering.fingerings {
                    if let fluteFingeringKeys = fluteFingering.keys {
                        XCTAssertTrue(fluteFingeringKeys.count == 16, "Instrument: \(fluteChart.instrument.type.rawValue), Note: \(fluteNoteFingering.notes[0]), Fingering: \(fluteFingering)")
                    } else {
                        XCTAssertNil(fluteFingering.keys, "Instrument: \(fluteChart.instrument.type.rawValue), Note: \(fluteNoteFingering.notes[0]), Fingering: \(fluteFingering)")
                    }
                }
            }
        }
    }
    
    func testClarinetFingering() {
        let clarinetChartCategory = chartsController.chartCategories[1]
        
        for clarinetChart in clarinetChartCategory.fingeringCharts {
            for clarinetNoteFingering in clarinetChart.noteFingerings {
                for clarinetFingering in clarinetNoteFingering.fingerings {
                    if let clarinetFingeringKeys = clarinetFingering.keys {
                        XCTAssertTrue(clarinetFingeringKeys.count == 24, "Instrument: \(clarinetChart.instrument.type.rawValue), Note: \(clarinetNoteFingering.notes[0]), Fingering: \(clarinetFingering)")
                    } else {
                        XCTAssertNil(clarinetFingering.keys, "Instrument: \(clarinetChart.instrument.type.rawValue), Note: \(clarinetNoteFingering.notes[0]), Fingering: \(clarinetFingering)")
                    }
                }
            }
        }
    }
    
    func testSaxophoneFingering() {
        let saxophoneChartCategory = chartsController.chartCategories[2]
        
        for (index, saxophoneChart) in saxophoneChartCategory.fingeringCharts.enumerated() {
            for saxophoneNoteFingering in saxophoneChart.noteFingerings {
                for saxophoneFingering in saxophoneNoteFingering.fingerings {
                    if let saxophoneFingeringKeys = saxophoneFingering.keys {
                        if index == 2 {
                            // Baritone Saxophone
                            XCTAssertTrue(saxophoneFingeringKeys.count == 24, "Instrument: \(saxophoneChart.instrument.type.rawValue), Note: \(saxophoneNoteFingering.notes[0]), Fingering: \(saxophoneFingering)")
                        } else {
                            XCTAssertTrue(saxophoneFingeringKeys.count == 23, "Instrument: \(saxophoneChart.instrument.type.rawValue), Note: \(saxophoneNoteFingering.notes[0]), Fingering: \(saxophoneFingering)")
                        }
                    } else {
                        XCTAssertNil(saxophoneFingering.keys, "Instrument: \(saxophoneChart.instrument.type.rawValue), Note: \(saxophoneNoteFingering.notes[0]), Fingering: \(saxophoneFingering)")
                    }
                }
            }
        }
    }
    
    func testTrumpetFingering() {
        let trumpetChartCategory = chartsController.chartCategories[3]
        
        for trumpetChart in trumpetChartCategory.fingeringCharts {
            for trumpetNoteFingering in trumpetChart.noteFingerings {
                for trumpetFingering in trumpetNoteFingering.fingerings {
                    if let trumpetFingeringKeys = trumpetFingering.keys {
                        XCTAssertTrue(trumpetFingeringKeys.count == 3, "Instrument: \(trumpetChart.instrument.type.rawValue), Note: \(trumpetNoteFingering.notes[0]), Fingering: \(trumpetFingering)")
                    } else {
                        XCTAssertNil(trumpetFingering.keys, "Instrument: \(trumpetChart.instrument.type.rawValue), Note: \(trumpetNoteFingering.notes[0]), Fingering: \(trumpetFingering)")
                    }
                }
            }
        }
    }
    
    func testMellophoneFingering() {
        let mellophoneChartCategory = chartsController.chartCategories[4]
        
        for mellophoneChart in mellophoneChartCategory.fingeringCharts {
            for mellophoneNoteFingering in mellophoneChart.noteFingerings {
                for mellophoneFingering in mellophoneNoteFingering.fingerings {
                    if let mellophoneFingeringKeys = mellophoneFingering.keys {
                        XCTAssertTrue(mellophoneFingeringKeys.count == 3, "Instrument: \(mellophoneChart.instrument.type.rawValue), Note: \(mellophoneNoteFingering.notes[0]), Fingering: \(mellophoneFingering)")
                    } else {
                        XCTAssertNil(mellophoneFingering.keys, "Instrument: \(mellophoneChart.instrument.type.rawValue), Note: \(mellophoneNoteFingering.notes[0]), Fingering: \(mellophoneFingering)")
                    }
                }
            }
        }
    }
    
    func testFrenchHornFingering() {
        let frenchHornChartCategory = chartsController.chartCategories[5]
        
        for (index, frenchHornChart) in frenchHornChartCategory.fingeringCharts.enumerated() {
            for frenchHornNoteFingering in frenchHornChart.noteFingerings {
                for frenchHornFingering in frenchHornNoteFingering.fingerings {
                    if let frenchHornFingeringKeys = frenchHornFingering.keys {
                        if index == 1 {
                            // F/Bb French Horn
                            XCTAssertTrue(frenchHornFingering.triggers?.count == 1, "Instrument: \(frenchHornChart.instrument.type.rawValue), Note: \(frenchHornNoteFingering.notes[0]), Fingering: \(frenchHornFingering)")
                        }
                        
                        XCTAssertTrue(frenchHornFingeringKeys.count == 3, "Instrument: \(frenchHornChart.instrument.type.rawValue), Note: \(frenchHornNoteFingering.notes[0]), Fingering: \(frenchHornFingering)")
                    } else {
                        XCTAssertNil(frenchHornFingering.keys, "Instrument: \(frenchHornChart.instrument.type.rawValue), Note: \(frenchHornNoteFingering.notes[0]), Fingering: \(frenchHornFingering)")
                    }
                }
            }
        }
    }
    
    func testTromboneFingering() {
        let tromboneChartCategory = chartsController.chartCategories[6]
        
        for (index, tromboneChart) in tromboneChartCategory.fingeringCharts.enumerated() {
            for tromboneNoteFingering in tromboneChart.noteFingerings {
                for tromboneFingering in tromboneNoteFingering.fingerings {
                    if let tromboneFingeringKeys = tromboneFingering.keys {
                        if index == 1 {
                            // F-Trigger Tenor Trombone
                            XCTAssertTrue(tromboneFingering.triggers?.count == 1, "Instrument: \(tromboneChart.instrument.type.rawValue), Note: \(tromboneNoteFingering.notes[0]), Fingering: \(tromboneFingering)")
                        }
                        
                        XCTAssertTrue(tromboneFingeringKeys.count == 0, "Instrument: \(tromboneChart.instrument.type.rawValue), Note: \(tromboneNoteFingering.notes[0]), Fingering: \(tromboneFingering)")
                        XCTAssertNotNil(tromboneFingering.position, "Instrument: \(tromboneChart.instrument.type.rawValue), Note: \(tromboneNoteFingering.notes[0]), Fingering: \(tromboneFingering)")
                    } else {
                        XCTAssertNil(tromboneFingering.keys, "Instrument: \(tromboneChart.instrument.type.rawValue), Note: \(tromboneNoteFingering.notes[0]), Fingering: \(tromboneFingering)")
                    }
                }
            }
        }
    }
    
    func testBaritoneFingering() {
        let baritoneChartCategory = chartsController.chartCategories[7]
        
        for baritoneChart in baritoneChartCategory.fingeringCharts {
            for baritoneNoteFingering in baritoneChart.noteFingerings {
                for baritoneFingering in baritoneNoteFingering.fingerings {
                    if let baritoneFingeringKeys = baritoneFingering.keys {
                        XCTAssertTrue(baritoneFingeringKeys.count == 3, "Instrument: \(baritoneChart.instrument.type.rawValue), Note: \(baritoneNoteFingering.notes[0]), Fingering: \(baritoneFingering)")
                    } else {
                        XCTAssertNil(baritoneFingering.keys, "Instrument: \(baritoneChart.instrument.type.rawValue), Note: \(baritoneNoteFingering.notes[0]), Fingering: \(baritoneFingering)")
                    }
                }
            }
        }
    }
    
    func testEuphoniumFingering() {
        let euphoniumChartCategory = chartsController.chartCategories[8]
        
        for euphoniumChart in euphoniumChartCategory.fingeringCharts {
            for euphoniumNoteFingering in euphoniumChart.noteFingerings {
                for euphoniumFingering in euphoniumNoteFingering.fingerings {
                    if let euphoniumFingeringKeys = euphoniumFingering.keys {
                        XCTAssertTrue(euphoniumFingeringKeys.count == 4, "Instrument: \(euphoniumChart.instrument.type.rawValue), Note: \(euphoniumNoteFingering.notes[0]), Fingering: \(euphoniumFingering)")
                    } else {
                        XCTAssertNil(euphoniumFingering.keys, "Instrument: \(euphoniumChart.instrument.type.rawValue), Note: \(euphoniumNoteFingering.notes[0]), Fingering: \(euphoniumFingering)")
                    }
                }
            }
        }
    }
    
    func testTubaFingering() {
        let tubaChartCategory = chartsController.chartCategories[9]
        
        for tubaChart in tubaChartCategory.fingeringCharts {
            for tubaNoteFingering in tubaChart.noteFingerings {
                for tubaFingering in tubaNoteFingering.fingerings {
                    if let tubaFingeringKeys = tubaFingering.keys {
                        XCTAssertTrue(tubaFingeringKeys.count == 3, "Instrument: \(tubaChart.instrument.type.rawValue), Note: \(tubaNoteFingering.notes[0]), Fingering: \(tubaFingering)")
                    } else {
                        XCTAssertNil(tubaFingering.keys, "Instrument: \(tubaChart.instrument.type.rawValue), Note: \(tubaNoteFingering.notes[0]), Fingering: \(tubaFingering)")
                    }
                }
            }
        }
    }
}

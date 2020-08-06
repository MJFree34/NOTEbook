//
//  NoteTests.swift
//  NOTEbookTests
//
//  Created by Matt Free on 6/27/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import XCTest
@testable import NOTEbook

class NoteTests: XCTestCase {
    let bassHighMediumASharp = Note(letter: .a, type: .sharp, pitch: .highMedium, clef: .bass)
    let bassLowMediumB = Note(letter: .b, type: .natural, pitch: .lowMedium, clef: .bass)
    let trebleLowC = Note(letter: .c, type: .natural, pitch: .low, clef: .treble)
    let trebleVeryHighDFlat = Note(letter: .d, type: .flat, pitch: .veryHigh, clef: .treble)
    let bassHighE = Note(letter: .e, type: .natural, pitch: .high, clef: .bass)
    let trebleVeryLowFSharp = Note(letter: .f, type: .sharp, pitch: .veryLow, clef: .treble)
    let bassLowGFlat = Note(letter: .g, type: .flat, pitch: .low, clef: .bass)
    
    func testCalculatePosition() {
        XCTAssertEqual(bassHighMediumASharp.position, NotePosition.middle1stSpace)
        XCTAssertEqual(bassLowMediumB.position, NotePosition.bottom3rdSpace)
        XCTAssertEqual(trebleLowC.position, NotePosition.bottom5thSpace)
        XCTAssertEqual(trebleVeryHighDFlat.position, NotePosition.top6thLine)
        XCTAssertEqual(bassHighE.position, NotePosition.top2ndLine)
        XCTAssertEqual(trebleVeryLowFSharp.position, NotePosition.bottom7thSpace)
        XCTAssertEqual(bassLowGFlat.position, NotePosition.bottom4thSpace)
    }
}

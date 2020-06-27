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
    var c3Note = Note(letter: .c, type: .natural, octave: .three)
    var cSharp3Note = Note(letter: .c, type: .sharp, octave: .three)
    var f4Note = Note(letter: .f, type: .natural, octave: .four)
    var g5Note = Note(letter: .g, type: .natural, octave: .five)
    var a5Note = Note(letter: .a, type: .natural, octave: .five)
    var b5Note = Note(letter: .b, type: .natural, octave: .five)
    var e6Note = Note(letter: .e, type: .natural, octave: .six)
    
    func testNumberOfExtraLines() {
        XCTAssertEqual(c3Note.numberOfExtraLines, 4)
        XCTAssertEqual(cSharp3Note.numberOfExtraLines, 4)
        XCTAssertEqual(f4Note.numberOfExtraLines, 0)
        XCTAssertEqual(g5Note.numberOfExtraLines, 0)
        XCTAssertEqual(a5Note.numberOfExtraLines, 1)
        XCTAssertEqual(b5Note.numberOfExtraLines, 1)
        XCTAssertEqual(e6Note.numberOfExtraLines, 3)
    }
    
    func testExtraLinesLocation() {
        XCTAssertEqual(c3Note.extraLinesLocation, .bottom)
        XCTAssertEqual(cSharp3Note.extraLinesLocation, .bottom)
        XCTAssertEqual(f4Note.extraLinesLocation, .none)
        XCTAssertEqual(g5Note.extraLinesLocation, .none)
        XCTAssertEqual(a5Note.extraLinesLocation, .top)
        XCTAssertEqual(b5Note.extraLinesLocation, .top)
        XCTAssertEqual(e6Note.extraLinesLocation, .top)
    }
    
    func testPreviousNote() {
        XCTAssertEqual(c3Note.previousNote(), Note(letter: .c, type: .natural, octave: .three))
        XCTAssertEqual(cSharp3Note.previousNote(), Note(letter: .c, type: .natural, octave: .three))
        XCTAssertEqual(f4Note.previousNote(), Note(letter: .e, type: .natural, octave: .four))
        XCTAssertEqual(g5Note.previousNote(), Note(letter: .g, type: .flat, octave: .five))
        XCTAssertEqual(a5Note.previousNote(), Note(letter: .a, type: .flat, octave: .five))
        XCTAssertEqual(b5Note.previousNote(), Note(letter: .b, type: .flat, octave: .five))
        XCTAssertEqual(e6Note.previousNote(), Note(letter: .e, type: .flat, octave: .six))
    }
    
    func testNextNote() {
        XCTAssertEqual(c3Note.nextNote(), Note(letter: .c, type: .sharp, octave: .three))
        XCTAssertEqual(cSharp3Note.nextNote(), Note(letter: .d, type: .natural, octave: .three))
        XCTAssertEqual(f4Note.nextNote(), Note(letter: .f, type: .sharp, octave: .four))
        XCTAssertEqual(g5Note.nextNote(), Note(letter: .g, type: .sharp, octave: .five))
        XCTAssertEqual(a5Note.nextNote(), Note(letter: .a, type: .sharp, octave: .five))
        XCTAssertEqual(b5Note.nextNote(), Note(letter: .c, type: .natural, octave: .six))
        XCTAssertEqual(e6Note.nextNote(), Note(letter: .f, type: .natural, octave: .six))
    }
}

//
//  DecodingTests.swift
//  NOTEbookTests
//
//  Created by Matt Free on 8/5/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import XCTest
@testable import NOTEbook

class DecodingTests: XCTestCase {
    func testNoteFingeringDecoding() {
        let noteFingeringData = """
        {
            "notes": [],
            "fingerings": []
        }
        """.data(using: .utf8)!
        
        let noteFingering = NoteFingering(notes: [], fingerings: [])
        
        XCTAssertNoThrow(try JSONDecoder().decode(NoteFingering.self, from: noteFingeringData))
        XCTAssertEqual(try! JSONDecoder().decode(NoteFingering.self, from: noteFingeringData), noteFingering)
    }
    
    func testFingeringDecoding() {
        let fingeringData = """
        {
            "keys": [
                true,
                true,
                true
            ]
        }
        """.data(using: .utf8)!
        
        let fingering = Fingering(keys: [true, true, true])
        
        XCTAssertNoThrow(try JSONDecoder().decode(Fingering.self, from: fingeringData))
        XCTAssertEqual(try! JSONDecoder().decode(Fingering.self, from: fingeringData), fingering)
    }
    
    func testNoteDecoding() {
        let noteData = """
        {
            "letter": "c",
            "type": "natural",
            "pitch": "highMedium",
            "clef": "treble"
        }
        """.data(using: .utf8)!
        
        let note = Note(letter: .c, type: .natural, pitch: .highMedium, clef: .treble)
        
        XCTAssertNoThrow(try JSONDecoder().decode(Note.self, from: noteData))
        XCTAssertEqual(try! JSONDecoder().decode(Note.self, from: noteData), note)
    }
}

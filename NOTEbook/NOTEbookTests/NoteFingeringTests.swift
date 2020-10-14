//
//  NoteFingeringTests.swift
//  NOTEbookTests
//
//  Created by Matt Free on 10/14/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import XCTest
@testable import NOTEbook

class NoteFingeringTests: XCTestCase {
    let blankFingering = Fingering(keys: nil, position: nil, triggers: nil)
    
    func testShorten() {
        let noteFingering0 = NoteFingering(notes: [], fingerings: [])
        let noteFingering1 = NoteFingering(notes: [], fingerings: [blankFingering])
        let noteFingering2 = NoteFingering(notes: [], fingerings: [blankFingering, blankFingering])
        let noteFingering3 = NoteFingering(notes: [], fingerings: [blankFingering, blankFingering, blankFingering])
        let noteFingering4 = NoteFingering(notes: [], fingerings: [blankFingering, blankFingering, blankFingering, blankFingering])
        let noteFingering5 = NoteFingering(notes: [], fingerings: [blankFingering, blankFingering, blankFingering, blankFingering, blankFingering])
        let noteFingering6 = NoteFingering(notes: [], fingerings: [blankFingering, blankFingering, blankFingering, blankFingering, blankFingering, blankFingering])
        let noteFingering7 = NoteFingering(notes: [], fingerings: [blankFingering, blankFingering, blankFingering, blankFingering, blankFingering, blankFingering, blankFingering])
        
        XCTAssertTrue(noteFingering0.shorten(to: 7).count == 0)
        XCTAssertTrue(noteFingering0.shorten(to: 6).count == 0)
        XCTAssertTrue(noteFingering0.shorten(to: 5).count == 0)
        XCTAssertTrue(noteFingering0.shorten(to: 4).count == 0)
        XCTAssertTrue(noteFingering0.shorten(to: 3).count == 0)
        XCTAssertTrue(noteFingering0.shorten(to: 2).count == 0)
        XCTAssertTrue(noteFingering0.shorten(to: 1).count == 0)
        
        XCTAssertTrue(noteFingering1.shorten(to: 7).count == 1)
        XCTAssertTrue(noteFingering1.shorten(to: 6).count == 1)
        XCTAssertTrue(noteFingering1.shorten(to: 5).count == 1)
        XCTAssertTrue(noteFingering1.shorten(to: 4).count == 1)
        XCTAssertTrue(noteFingering1.shorten(to: 3).count == 1)
        XCTAssertTrue(noteFingering1.shorten(to: 2).count == 1)
        XCTAssertTrue(noteFingering1.shorten(to: 1).count == 1)
        
        XCTAssertTrue(noteFingering2.shorten(to: 7).count == 2)
        XCTAssertTrue(noteFingering2.shorten(to: 6).count == 2)
        XCTAssertTrue(noteFingering2.shorten(to: 5).count == 2)
        XCTAssertTrue(noteFingering2.shorten(to: 4).count == 2)
        XCTAssertTrue(noteFingering2.shorten(to: 3).count == 2)
        XCTAssertTrue(noteFingering2.shorten(to: 2).count == 2)
        XCTAssertTrue(noteFingering2.shorten(to: 1).count == 1)
        
        XCTAssertTrue(noteFingering3.shorten(to: 7).count == 3)
        XCTAssertTrue(noteFingering3.shorten(to: 6).count == 3)
        XCTAssertTrue(noteFingering3.shorten(to: 5).count == 3)
        XCTAssertTrue(noteFingering3.shorten(to: 4).count == 3)
        XCTAssertTrue(noteFingering3.shorten(to: 3).count == 3)
        XCTAssertTrue(noteFingering3.shorten(to: 2).count == 2)
        XCTAssertTrue(noteFingering3.shorten(to: 1).count == 1)
        
        XCTAssertTrue(noteFingering4.shorten(to: 7).count == 4)
        XCTAssertTrue(noteFingering4.shorten(to: 6).count == 4)
        XCTAssertTrue(noteFingering4.shorten(to: 5).count == 4)
        XCTAssertTrue(noteFingering4.shorten(to: 4).count == 4)
        XCTAssertTrue(noteFingering4.shorten(to: 3).count == 3)
        XCTAssertTrue(noteFingering4.shorten(to: 2).count == 2)
        XCTAssertTrue(noteFingering4.shorten(to: 1).count == 1)
        
        XCTAssertTrue(noteFingering5.shorten(to: 7).count == 5)
        XCTAssertTrue(noteFingering5.shorten(to: 6).count == 5)
        XCTAssertTrue(noteFingering5.shorten(to: 5).count == 5)
        XCTAssertTrue(noteFingering5.shorten(to: 4).count == 4)
        XCTAssertTrue(noteFingering5.shorten(to: 3).count == 3)
        XCTAssertTrue(noteFingering5.shorten(to: 2).count == 2)
        XCTAssertTrue(noteFingering5.shorten(to: 1).count == 1)
        
        XCTAssertTrue(noteFingering6.shorten(to: 7).count == 6)
        XCTAssertTrue(noteFingering6.shorten(to: 6).count == 6)
        XCTAssertTrue(noteFingering6.shorten(to: 5).count == 5)
        XCTAssertTrue(noteFingering6.shorten(to: 4).count == 4)
        XCTAssertTrue(noteFingering6.shorten(to: 3).count == 3)
        XCTAssertTrue(noteFingering6.shorten(to: 2).count == 2)
        XCTAssertTrue(noteFingering6.shorten(to: 1).count == 1)
        
        XCTAssertTrue(noteFingering7.shorten(to: 7).count == 7)
        XCTAssertTrue(noteFingering7.shorten(to: 6).count == 6)
        XCTAssertTrue(noteFingering7.shorten(to: 5).count == 5)
        XCTAssertTrue(noteFingering7.shorten(to: 4).count == 4)
        XCTAssertTrue(noteFingering7.shorten(to: 3).count == 3)
        XCTAssertTrue(noteFingering7.shorten(to: 2).count == 2)
        XCTAssertTrue(noteFingering7.shorten(to: 1).count == 1)
    }
}

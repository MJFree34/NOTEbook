//
//  Instrument.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum InstrumentType: String, Decodable {
    case trumpet = "Trumpet"
    case euphoniumTCNC = "Euphonium T.C. Non-Compensating"
}

struct Instrument: Decodable, Equatable {
    var type: InstrumentType
    var clef: Clef
    var fingeringWidth: Int
    var offset: Double
}

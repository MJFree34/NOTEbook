//
//  Instrument.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum InstrumentType: String, Decodable {
    case trumpet = "Trumpet (Cornet)"
    case euphoniumTCNC = "Euphonium T.C. Non-Compensating"
    case euphoniumTCC = "Euphonium T.C. Compensating"
    case euphoniumBCNC = "Euphonium B.C. Non-Compensating"
    case euphoniumBCC = "Euphonium B.C. Compensating"
    case baritoneTC = "Baritone T.C."
    case baritoneBC = "Baritone B.C."
    case tenorTrombone = "Tenor Trombone"
    case fTriggerTenorTrombone = "F-Trigger Tenor Trombone"
}

struct Instrument: Decodable, Equatable {
    var type: InstrumentType
    var clef: Clef
    var fingeringWidth: Int
    var offset: Double
}

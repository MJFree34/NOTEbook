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
    case euphoniumTCC = "Euphonium T.C. Compensating"
    case euphoniumBCNC = "Euphonium B.C. Non-Compensating"
    case euphoniumBCC = "Euphonium B.C. Compensating"
    case baritoneTC = "Baritone T.C."
    case baritoneBC = "Baritone B.C."
    case tenorTrombone = "Tenor Trombone"
    case fTriggerTenorTrombone = "F-Trigger Tenor Trombone"
    case mellophone = "Mellophone"
    case threeValveBBbTuba = "3-Valve BBb Tuba"
    case threeValveEbTuba = "3-Valve Eb Tuba"
    case fFrenchHorn = "F French Horn"
}

struct Instrument: Decodable, Equatable {
    var type: InstrumentType
    var clef: Clef
    var fingeringWidth: Int
    var offset: Double
}

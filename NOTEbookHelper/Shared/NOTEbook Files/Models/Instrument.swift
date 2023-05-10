//
//  Instrument.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum InstrumentType: String, Codable, CaseIterable {
    case flute = "Flute"
    case clarinet = "Clarinet"
    case altoSaxophone = "Alto Saxophone"
    case tenorSaxophone = "Tenor Saxophone"
    case baritoneSaxophone = "Baritone Saxophone"
    case trumpet = "Trumpet"
    case mellophone = "Mellophone"
    case fFrenchHorn = "F French Horn"
    case fBbFrenchHorn = "F/Bb French Horn"
    case euphoniumTCNC = "Euphonium T.C. Non-Compensating"
    case euphoniumTCC = "Euphonium T.C. Compensating"
    case euphoniumBCNC = "Euphonium B.C. Non-Compensating"
    case euphoniumBCC = "Euphonium B.C. Compensating"
    case baritoneTC = "Baritone T.C."
    case baritoneBC = "Baritone B.C."
    case tenorTrombone = "Tenor Trombone"
    case fTriggerTenorTrombone = "F-Trigger Tenor Trombone"
    case threeValveBBbTuba = "3-Valve BBb Tuba"
    case threeValveEbTuba = "3-Valve Eb Tuba"
}

extension InstrumentType: Identifiable {
    var id: String { rawValue }
}

struct Instrument: Codable, Equatable {
    var type: InstrumentType
    var offset: Double
    
    init(type: InstrumentType, offset: Double) {
        self.type = type
        self.offset = offset
    }
}

extension Instrument: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}

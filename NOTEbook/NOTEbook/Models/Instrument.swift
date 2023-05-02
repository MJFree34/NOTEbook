//
//  Instrument.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//
import Foundation

enum InstrumentType: String, Codable, CaseIterable {
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
    case fBbFrenchHorn = "F/Bb French Horn"
    case flute = "Flute"
    case clarinet = "Clarinet"
    case altoSaxophone = "Alto Saxophone"
    case tenorSaxophone = "Tenor Saxophone"
    case baritoneSaxophone = "Baritone Saxophone"
}

extension InstrumentType: Identifiable {
    var id: String { rawValue }
}

struct Instrument: Codable, Equatable {
    var type: InstrumentType
    var fingeringWidth: Int
    var chartCellHeight: Int
    var chartCenterOfStaffFromTop: Int
    var offset: Double
    var chartFingeringHeight: Int
    var maximumSpacingFingerings: Double
    
    init(type: InstrumentType, fingeringWidth: Int, chartCellHeight: Int, chartCenterOfStaffFromTop: Int, offset: Double, chartFingeringHeight: Int, maximumSpacingFingerings: Double) {
        self.type = type
        self.fingeringWidth = fingeringWidth
        self.chartCellHeight = chartCellHeight
        self.chartCenterOfStaffFromTop = chartCenterOfStaffFromTop
        self.offset = offset
        self.chartFingeringHeight = chartFingeringHeight
        self.maximumSpacingFingerings = maximumSpacingFingerings
    }
    
    init(type: InstrumentType) {
        self.type = type
        self.fingeringWidth = 0
        self.chartCellHeight = 0
        self.chartCenterOfStaffFromTop = 0
        self.offset = 0
        self.chartFingeringHeight = 0
        self.maximumSpacingFingerings = 0
    }
}

extension Instrument: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}

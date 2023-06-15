//
//  Instrument.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum InstrumentType: String, Codable, CaseIterable {
    case cFlute = "C Flute"
    case bbSopranoClarinet = "Bb Soprano Clarinet"
    case ebAltoSaxophone = "Eb Alto Saxophone"
    case bbTenorSaxophone = "Bb Tenor Saxophone"
    case ebBaritoneSaxophone = "Eb Baritone Saxophone"
    case bbTrumpet = "Bb Trumpet"
    case fMellophone = "F Mellophone"
    case fSingleFrenchHorn = "F Single French Horn"
    case fBbDoubleFrenchHorn = "F/Bb Double French Horn"
    case bbTenorTrombone = "Bb Tenor Trombone"
    case fTriggerBbTenorTrombone = "F-Trigger Bb Tenor Trombone"
    case bbBaritoneHorn = "Bb Baritone Horn"
    case fourValveBbEuphoniumCompensating = "4-Valve Bb Euphonium Compensating"
    case fourValveBbEuphoniumNonCompensating = "4-Valve Bb Euphonium Non-Compensating"
    case threeValveBBbTuba = "3-Valve BBb Tuba"
    case threeValveEbTuba = "3-Valve Eb Tuba"
}

extension InstrumentType: Identifiable {
    var id: String { rawValue }
}

struct Instrument: Codable, Equatable {
    var type: InstrumentType
    var offset: Double
    
    // UNCOMMENT WHEN OLD UI IS DELETED
    init(type: InstrumentType, offset: Double) {
        self.type = type
        self.offset = offset
    }
    
    // MARK: - FOR OLD UI DELETE WHEN REPLACED
    var fingeringWidth: Int = 0
    var chartCellHeight: Int = 0
    var chartCenterOfStaffFromTop: Int = 0
    var chartFingeringHeight: Int = 0
    var maximumSpacingFingerings: Double = 0
    
    init(type: InstrumentType, fingeringWidth: Int, chartCellHeight: Int, chartCenterOfStaffFromTop: Int, offset: Double, chartFingeringHeight: Int, maximumSpacingFingerings: Double) {
        self.type = type
        self.fingeringWidth = fingeringWidth
        self.chartCellHeight = chartCellHeight
        self.chartCenterOfStaffFromTop = chartCenterOfStaffFromTop
        self.offset = offset
        self.chartFingeringHeight = chartFingeringHeight
        self.maximumSpacingFingerings = maximumSpacingFingerings
    }
    // END OLD UI
}

extension Instrument: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}

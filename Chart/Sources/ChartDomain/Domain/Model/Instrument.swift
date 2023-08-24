//
//  Instrument.swift
//  ChartDomain
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matthew Free. All rights reserved.
//

import Foundation

public struct Instrument: Codable, Equatable {
    public enum InstrumentType: String, Codable, CaseIterable {
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

    public var type: InstrumentType
    public var offset: Double

    public init(type: InstrumentType, offset: Double) {
        self.type = type
        self.offset = offset
    }
}

extension Instrument: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}

extension Instrument.InstrumentType: Identifiable {
    public var id: String { rawValue }
}

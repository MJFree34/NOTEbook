//
//  ChartCategory.swift
//  NoteLibrary
//
//  Created by Matt Free on 9/5/20.
//

import Foundation

public struct ChartCategory: Codable {
    public enum CategoryType: String, Codable, CaseIterable {
        case flute = "Flute"
        case clarinet = "Clarinet"
        case saxophone = "Saxophone"
        case trumpet = "Trumpet"
        case mellophone = "Mellophone"
        case frenchHorn = "French Horn"
        case trombone = "Trombone"
        case baritoneHorn = "Baritone Horn"
        case euphonium = "Euphonium"
        case tuba = "Tuba"
    }

    public var type: CategoryType
    public var section: ChartSection
    public var fingeringCharts: [FingeringChart]

    public var name: String { type.rawValue }

    public init(type: CategoryType, section: ChartSection, fingeringCharts: [FingeringChart]) {
        self.type = type
        self.section = section
        self.fingeringCharts = fingeringCharts
    }
}

extension ChartCategory: Identifiable {
    public var id: String { name }
}

extension ChartCategory.CategoryType: Identifiable {
    public var id: String { rawValue }
}

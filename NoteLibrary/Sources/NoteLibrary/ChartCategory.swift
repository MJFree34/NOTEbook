//
//  ChartCategory.swift
//  NoteLibrary
//
//  Created by Matt Free on 9/5/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

struct ChartCategory: Codable {
    enum CategoryType: String, Codable, CaseIterable {
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

    var type: CategoryType
    var section: ChartSection
    var fingeringCharts: [FingeringChart]
    
    var name: String { type.rawValue }
}

extension ChartCategory: Identifiable {
    var id: String { name }
}

extension ChartCategory.CategoryType: Identifiable {
    var id: String { rawValue }
}

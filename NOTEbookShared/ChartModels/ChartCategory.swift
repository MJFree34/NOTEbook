//
//  ChartCategory.swift
//  NOTEbook
//
//  Created by Matt Free on 9/5/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum ChartSection: String, Codable, CaseIterable {
    case woodwinds = "Woodwinds"
    case brass = "Brass"
}

extension ChartSection: Identifiable {
    var id: String { rawValue }
}

enum ChartCategoryType: String, Codable, CaseIterable {
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

extension ChartCategoryType: Identifiable {
    var id: String { rawValue }
}

struct ChartCategory: Codable {
    var type: ChartCategoryType
    var section: ChartSection
    var fingeringCharts: [FingeringChart]
    
    var name: String { type.rawValue }
}

extension ChartCategory: Identifiable {
    var id: String { name }
}

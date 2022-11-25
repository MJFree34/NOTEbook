//
//  ChartCategory.swift
//  NOTEbook
//
//  Created by Matt Free on 9/5/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum ChartSection: String, Decodable, CaseIterable {
    case woodwinds = "Woodwinds"
    case brass = "Brass"
}

extension ChartSection: Identifiable {
    var id: String { rawValue }
}

struct ChartCategory: Decodable {
    var name: String
    var section: ChartSection
    var fingeringCharts: [FingeringChart]
}

extension ChartCategory: Identifiable {
    var id: String { name }
}

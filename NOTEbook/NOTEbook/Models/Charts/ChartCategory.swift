//
//  ChartCategory.swift
//  NOTEbook
//
//  Created by Matt Free on 9/5/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum ChartCategoryType: String, Decodable {
    case woodwinds = "Woodwinds"
    case brass = "Brass"
}

struct ChartCategory: Decodable {
    var name: String
    var type: ChartCategoryType
    var fingeringCharts: [FingeringChart]
}

extension ChartCategory: Identifiable {
    var id: String { name }
}

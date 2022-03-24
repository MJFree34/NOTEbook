//
//  ChartCategory.swift
//  NOTEbook
//
//  Created by Matt Free on 9/5/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

struct ChartCategory: Decodable {
    var name: String
    var fingeringCharts: [FingeringChart]
}

extension ChartCategory: Identifiable {
    var id: String { name }
}

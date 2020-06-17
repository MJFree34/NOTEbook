//
//  FingeringChart.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

struct FingeringChart: Codable {
    var instrument: Instrument
    var noteFingerings: [NoteFingering]
}

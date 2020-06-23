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
    var startingNote: Note
    var naturalNotes: [Note]
    var flatNotes: [Note]
    var sharpNotes: [Note]
    var noteFingerings: [NoteFingering]
}

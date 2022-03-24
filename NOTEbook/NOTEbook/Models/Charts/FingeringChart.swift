//
//  FingeringChart.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

struct FingeringChart: Decodable {
    var instrument: Instrument
    var centerNote: Note
    var naturalNotes: [Note]
    var flatNotes: [Note]
    var sharpNotes: [Note]
    var noteFingerings: [NoteFingering]
    
    var name: String { instrument.type.rawValue }
}

extension FingeringChart: Identifiable {
    var id: String { name }
}

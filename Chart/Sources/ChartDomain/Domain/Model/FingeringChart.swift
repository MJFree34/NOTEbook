//
//  FingeringChart.swift
//  ChartDomain
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matthew Free. All rights reserved.
//

import Foundation

public struct FingeringChart: Codable {
    public var instrument: Instrument
    public var centerNote: Note?
    public var naturalNotes: [Note]
    public var flatNotes: [Note]
    public var sharpNotes: [Note]
    public var noteFingerings: [NoteFingering]

    public init(
        instrument: Instrument,
        centerNote: Note,
        naturalNotes: [Note],
        flatNotes: [Note],
        sharpNotes: [Note],
        noteFingerings: [NoteFingering]
    ) {
        self.instrument = instrument
        self.centerNote = centerNote
        self.naturalNotes = naturalNotes
        self.flatNotes = flatNotes
        self.sharpNotes = sharpNotes
        self.noteFingerings = noteFingerings
    }
}

extension FingeringChart: Identifiable {
    public var id: String { instrument.detailName }
}

extension FingeringChart: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(instrument)
    }
}

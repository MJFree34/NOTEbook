//
//  FingeringChart.swift
//  NoteLibrary
//
//  Created by Matt Free on 6/16/20.
//

import Foundation

public struct FingeringChart: Codable {
    public var instrument: Instrument
    public var centerNote: Note?
    public var naturalNotes: [Note]
    public var flatNotes: [Note]
    public var sharpNotes: [Note]
    public var noteFingerings: [NoteFingering]

    public var name: String { instrument.type.rawValue }

    init(instrument: Instrument, centerNote: Note? = nil, naturalNotes: [Note], flatNotes: [Note], sharpNotes: [Note], noteFingerings: [NoteFingering]) {
        self.instrument = instrument
        self.centerNote = centerNote
        self.naturalNotes = naturalNotes
        self.flatNotes = flatNotes
        self.sharpNotes = sharpNotes
        self.noteFingerings = noteFingerings
    }
}

extension FingeringChart: Identifiable {
    public var id: String { name }
}

extension FingeringChart: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(instrument)
    }
}

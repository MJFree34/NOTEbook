//
//  FingeringChart.swift
//  ChartDomain
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matthew Free. All rights reserved.
//

import Foundation

public struct FingeringChart: Codable, Identifiable {
    private enum CodingKeys: CodingKey {
        case instrument
        case centerNote
        case naturalNotes
        case flatNotes
        case sharpNotes
        case noteFingerings
    }

    public var id = UUID()
    public var instrument: Instrument
    public var centerNote: Note
    public var naturalNotes: [Note]
    public var flatNotes: [Note]
    public var sharpNotes: [Note]
    public var noteFingerings: [NoteFingering]

    public init(
        id: UUID,
        instrument: Instrument,
        centerNote: Note,
        naturalNotes: [Note],
        flatNotes: [Note],
        sharpNotes: [Note],
        noteFingerings: [NoteFingering]
    ) {
        self.id = id
        self.instrument = instrument
        self.centerNote = centerNote
        self.naturalNotes = naturalNotes
        self.flatNotes = flatNotes
        self.sharpNotes = sharpNotes
        self.noteFingerings = noteFingerings
    }

    public init(
        instrument: Instrument,
        centerNote: Note,
        naturalNotes: [Note],
        flatNotes: [Note],
        sharpNotes: [Note],
        noteFingerings: [NoteFingering]
    ) {
        self.init(
            id: UUID(),
            instrument: instrument,
            centerNote: centerNote,
            naturalNotes: naturalNotes,
            flatNotes: flatNotes,
            sharpNotes: sharpNotes,
            noteFingerings: noteFingerings
        )
    }
}

extension FingeringChart: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(instrument)
    }
}

extension FingeringChart {
    public static let placeholder = FingeringChart(
        instrument: .placeholder,
        centerNote: Note(letter: .c, type: .natural, octave: .five, clef: .treble),
        naturalNotes: [Note(letter: .c, type: .natural, octave: .five, clef: .treble)],
        flatNotes: [Note(letter: .b, type: .natural, octave: .four, clef: .treble)],
        sharpNotes: [Note(letter: .c, type: .sharp, octave: .five, clef: .treble)],
        noteFingerings: [
            NoteFingering(
                notes: [
                    Note(letter: .b, type: .natural, octave: .four, clef: .treble)
                ], fingerings: [
                    KeysFingering(
                        keys: [
                            false,
                            true,
                            false
                        ]
                    ),
                    KeysFingering(
                        keys: [
                            true,
                            false,
                            true
                        ]
                    )
                ]
            ),
            NoteFingering(
                notes: [
                    Note(letter: .c, type: .natural, octave: .five, clef: .treble)
                ], fingerings: [
                    KeysFingering(
                        keys: [
                            false,
                            false,
                            false
                        ]
                    ),
                    KeysFingering(
                        keys: [
                            false,
                            true,
                            true
                        ]
                    )
                ]
            ),
            NoteFingering(
                notes: [
                    Note(letter: .c, type: .sharp, octave: .five, clef: .treble),
                    Note(letter: .d, type: .flat, octave: .five, clef: .treble)
                ], fingerings: [
                    KeysFingering(
                        keys: [
                            true,
                            true,
                            false
                        ]
                    ),
                    KeysFingering(
                        keys: [
                            true,
                            true,
                            true
                        ]
                    ),
                    KeysFingering(
                        keys: [
                            false,
                            false,
                            true
                        ]
                    )
                ]
            )
        ]
    )
}

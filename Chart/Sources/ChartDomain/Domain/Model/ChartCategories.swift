//
//  ChartCategories.swift
//  ChartDomain
//
//  Created by Matt Free on 7/20/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

public typealias ChartCategories = [ChartCategory]

extension ChartCategories {
    public func categories(in section: ChartSection) -> [ChartCategory] {
        filter { $0.section == section }
    }
}

extension ChartCategories {
    public static var placeholder: ChartCategories {
        [
            ChartCategory(
                type: .flute,
                section: .woodwinds,
                fingeringCharts: [
                    FingeringChart(
                        instrument: Instrument(type: .cFlute, offset: 0),
                        centerNote: Note(letter: .c, type: .natural, octave: .four, clef: .treble),
                        naturalNotes: [],
                        flatNotes: [],
                        sharpNotes: [],
                        noteFingerings: []
                    )
                ]
            ),
            ChartCategory(
                type: .saxophone,
                section: .woodwinds,
                fingeringCharts: [
                    FingeringChart(
                        instrument: Instrument(type: .ebAltoSaxophone, offset: 0),
                        centerNote: Note(letter: .c, type: .natural, octave: .four, clef: .treble),
                        naturalNotes: [],
                        flatNotes: [],
                        sharpNotes: [],
                        noteFingerings: []
                    ),
                    FingeringChart(
                        instrument: Instrument(type: .bbTenorSaxophone, offset: 0),
                        centerNote: Note(letter: .c, type: .natural, octave: .four, clef: .treble),
                        naturalNotes: [],
                        flatNotes: [],
                        sharpNotes: [],
                        noteFingerings: []
                    ),
                    FingeringChart(
                        instrument: Instrument(type: .ebBaritoneSaxophone, offset: 0),
                        centerNote: Note(letter: .c, type: .natural, octave: .four, clef: .treble),
                        naturalNotes: [],
                        flatNotes: [],
                        sharpNotes: [],
                        noteFingerings: []
                    )
                ]
            ),
            ChartCategory(
                type: .trumpet,
                section: .brass,
                fingeringCharts: [
                    FingeringChart(
                        instrument: Instrument(type: .bbTrumpet, offset: 0),
                        centerNote: Note(letter: .c, type: .natural, octave: .four, clef: .treble),
                        naturalNotes: [],
                        flatNotes: [],
                        sharpNotes: [],
                        noteFingerings: []
                    )
                ]
            ),
            ChartCategory(
                type: .trombone,
                section: .brass,
                fingeringCharts: [
                    FingeringChart(
                        instrument: Instrument(type: .bbTenorTrombone, offset: 0),
                        centerNote: Note(letter: .c, type: .natural, octave: .four, clef: .treble),
                        naturalNotes: [],
                        flatNotes: [],
                        sharpNotes: [],
                        noteFingerings: []
                    ),
                    FingeringChart(
                        instrument: Instrument(type: .fTriggerBbTenorTrombone, offset: 0),
                        centerNote: Note(letter: .c, type: .natural, octave: .four, clef: .treble),
                        naturalNotes: [],
                        flatNotes: [],
                        sharpNotes: [],
                        noteFingerings: []
                    )
                ]
            )
        ]
    }
}

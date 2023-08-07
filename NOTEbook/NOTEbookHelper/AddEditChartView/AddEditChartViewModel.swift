//
//  AddEditChartViewModel.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 7/29/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import Common
import SwiftUI

// swiftlint:disable no_fatal_errors
final class AddEditChartViewModel: ObservableObject {
    enum NoteRangeSelection: String {
        case none
        case min
        case center
        case max
    }

    @Published var name = ""
    @Published var detailName = ""
    @Published var clef: Clef?
    @Published var noteRangeSelection: NoteRangeSelection = .none
    @Published var minNote: Note?
    @Published var centerNote: Note?
    @Published var maxNote: Note?

    let noteLineSpacing = 10.0

    private var noteFingerings: [NoteFingering]?
    private var id = UUID()

    private var disposeBag = DisposeBag()

    init(chart: FingeringChart?) {
        if let chart {
            self.name = chart.instrument.name
            self.detailName = chart.instrument.detailName
            self.clef = chart.naturalNotes.first?.clef
            self.minNote = chart.naturalNotes.first
            self.centerNote = chart.centerNote
            self.maxNote = chart.naturalNotes.last

            self.noteFingerings = chart.noteFingerings
        }

        setupObserving()
    }

    private func setupObserving() {
        $clef
            .receive(on: RunLoop.main)
            .sink { [weak self] newClef in
                guard let self, let newClef else { return }
                self.clefUpdated(to: newClef)
            }
            .store(in: &disposeBag)
    }

    private func clefUpdated(to newClef: Clef) {
        if var minNote, var centerNote, var maxNote {
            if minNote < Note.minNote(for: newClef) {
                minNote = Note.minNote(for: newClef)
            } else if minNote > Note.maxNote(for: newClef) {
                minNote = Note.maxNote(for: newClef)
            }

            if centerNote < Note.minNote(for: newClef) {
                centerNote = Note.minNote(for: newClef)
            } else if centerNote > Note.maxNote(for: newClef) {
                centerNote = Note.maxNote(for: newClef)
            }

            if maxNote < Note.minNote(for: newClef) {
                maxNote = Note.minNote(for: newClef)
            } else if maxNote > Note.maxNote(for: newClef) {
                maxNote = Note.maxNote(for: newClef)
            }

            self.minNote = Note(letter: minNote.letter, type: minNote.type, octave: minNote.octave, clef: newClef)
            self.centerNote = Note(letter: centerNote.letter, type: centerNote.type, octave: centerNote.octave, clef: newClef)
            self.maxNote = Note(letter: maxNote.letter, type: maxNote.type, octave: maxNote.octave, clef: newClef)
        } else {
            self.minNote = Note.middleNote(for: newClef)
            self.centerNote = Note.middleNote(for: newClef)
            self.maxNote = Note.middleNote(for: newClef)
        }
    }

    func increment() {
        if let minNote, let centerNote, let maxNote {
            switch noteRangeSelection {
            case .min:
                self.minNote = minNote.higherNote()
            case .center:
                self.centerNote = centerNote.higherNote()
            case .max:
                self.maxNote = maxNote.higherNote()
            case .none:
                break
            }
        }
    }

    func decrement() {
        if let minNote, let centerNote, let maxNote {
            switch noteRangeSelection {
            case .min:
                self.minNote = minNote.lowerNote()
            case .center:
                self.centerNote = centerNote.lowerNote()
            case .max:
                self.maxNote = maxNote.lowerNote()
            case .none:
                break
            }
        }
    }

    func disableIncrement() -> Bool {
        if let minNote, let centerNote, let maxNote, let clef {
            switch noteRangeSelection {
            case .min:
                return minNote.position == Note.maxNote(for: clef).position || minNote.position == centerNote.position
            case .center:
                return centerNote.position == maxNote.position
            case .max:
                return maxNote.position == Note.maxNote(for: clef).position
            case .none:
                return true
            }
        }
        return true
    }

    func disableDecrement() -> Bool {
        if let minNote, let centerNote, let maxNote, let clef {
            switch noteRangeSelection {
            case .min:
                return minNote.position == Note.minNote(for: clef).position
            case .center:
                return centerNote.position == minNote.position
            case .max:
                return maxNote.position == Note.minNote(for: clef).position || maxNote.position == centerNote.position
            case .none:
                return true
            }
        }
        return true
    }

    func calculatedExtraLinesOffset(positionsFromCenterStaff: Int, extraLines: Int) -> Double {
        let isInSpace = abs(positionsFromCenterStaff) % 2 == 1
        let isBelowStaff = positionsFromCenterStaff < -4

        if isBelowStaff {
            if isInSpace {
                return Double(-Int(noteLineSpacing) * (extraLines - 1) - Int(noteLineSpacing) - 1)
            }
            return Double(-Int(noteLineSpacing) * (extraLines - 1) - 1)
        }

        if isInSpace {
            return Double(Int(noteLineSpacing) * (extraLines - 1) + Int(noteLineSpacing) - 1)
        }
        return Double(Int(noteLineSpacing) * (extraLines - 1) - 1)
    }

    func rangeSelectionTapped(_ selection: NoteRangeSelection) {
        if noteRangeSelection != selection {
            noteRangeSelection = selection
        } else {
            noteRangeSelection = .none
        }
    }

    func createChart() -> FingeringChart {
        guard let minNote, let centerNote, let maxNote else { fatalError("Chart creation failed") }

        let naturalNotes = generateNoteList(minNote: minNote, maxNote: maxNote, listNoteType: .natural)
        let flatNotes = generateNoteList(minNote: minNote, maxNote: maxNote, listNoteType: .flat)
        let sharpNotes = generateNoteList(minNote: minNote, maxNote: maxNote, listNoteType: .sharp)
        let noteFingerings = generateNoteFingerings(naturalNotes: naturalNotes, flatNotes: flatNotes, sharpNotes: sharpNotes)
        let offset = generateOffset(minNote: minNote, maxNote: maxNote)

        let instrument = Instrument(name: name, detailName: detailName, offset: offset)

        return FingeringChart(
            id: id,
            instrument: instrument,
            centerNote: centerNote,
            naturalNotes: naturalNotes,
            flatNotes: flatNotes,
            sharpNotes: sharpNotes,
            noteFingerings: noteFingerings
        )
    }

    private func generateNoteList(minNote: Note, maxNote: Note, listNoteType: NoteType) -> [Note] {
        var list = [minNote.transpose(to: listNoteType)]
        var currentNote = minNote

        while currentNote != maxNote {
            currentNote = currentNote.higherNote()
            list.append(currentNote.transpose(to: listNoteType))
        }

        return list
    }

    private func generateNoteFingerings(naturalNotes: [Note], flatNotes: [Note], sharpNotes: [Note]) -> [NoteFingering] {
        var newNoteFingerings = [NoteFingering]()

        var index = 0

        if flatNotes[index].type == .flat {
            let flatNote = flatNotes[index]
            let sharpNote = flatNote.transposeDownHalfStep().transposeUpHalfStep()
            newNoteFingerings.append(NoteFingering(notes: [sharpNote, flatNote], fingerings: []))
        } else {
            let flatNote = flatNotes[index]
            newNoteFingerings.append(NoteFingering(notes: [flatNote], fingerings: []))
        }

        newNoteFingerings.append(NoteFingering(notes: [naturalNotes[index]], fingerings: []))

        if sharpNotes[index].type == .sharp {
            let sharpNote = sharpNotes[index]
            let flatNote = sharpNote.transposeUpHalfStep().transposeDownHalfStep()
            newNoteFingerings.append(NoteFingering(notes: [sharpNote, flatNote], fingerings: []))
        } else if naturalNotes.count == 1 {
            let sharpNote = sharpNotes[index]
            newNoteFingerings.append(NoteFingering(notes: [sharpNote], fingerings: []))
        }

        index += 1

        while index < naturalNotes.count {
            let naturalNote = naturalNotes[index]
            newNoteFingerings.append(NoteFingering(notes: [naturalNote], fingerings: []))

            if sharpNotes[index].type == .sharp {
                let flatNote: Note
                let sharpNote = sharpNotes[index]

                if index == naturalNotes.count - 1 {
                    flatNote = sharpNote.transposeUpHalfStep().transposeDownHalfStep()
                } else {
                    flatNote = flatNotes[index + 1]
                }

                newNoteFingerings.append(NoteFingering(notes: [sharpNote, flatNote], fingerings: []))
            }

            index += 1
        }

        if let oldNoteFingerings = noteFingerings {
            var oldIndex = 0
            var newIndex = 0

            if let matchIndex = oldNoteFingerings.firstIndex(where: { $0.notes == newNoteFingerings[0].notes }) {
                oldIndex = matchIndex
            } else if let matchIndex = newNoteFingerings.firstIndex(where: { $0.notes == oldNoteFingerings[0].notes }) {
                newIndex = matchIndex
            }

            while oldIndex < oldNoteFingerings.count
                    && newIndex < newNoteFingerings.count
                    && oldNoteFingerings[oldIndex].notes == newNoteFingerings[newIndex].notes {
                newNoteFingerings[newIndex].fingerings = oldNoteFingerings[oldIndex].fingerings
                oldIndex += 1
                newIndex += 1
            }
        }

        return newNoteFingerings
    }

    private func generateOffset(minNote: Note, maxNote: Note) -> Double {
        var minPositions = minNote.positionsFromCenterStaff
        var maxPositions = maxNote.positionsFromCenterStaff

        if minPositions >= -4 && minPositions <= 4 {
            minPositions = 0
        } else {
            minPositions += minPositions < 0 ? 4 : -4
        }

        if maxPositions >= -4 && maxPositions <= 4 {
            maxPositions = 0
        } else {
            maxPositions += maxPositions < 0 ? 4 : -4
        }

        return Double(maxPositions + minPositions) / 4.0
    }
}

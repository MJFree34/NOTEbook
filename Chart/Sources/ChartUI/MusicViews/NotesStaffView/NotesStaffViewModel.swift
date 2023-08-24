//
//  NotesStaffViewModel.swift
//  ChartUI
//
//  Created by Matt Free on 8/4/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import Foundation

final class NotesStaffViewModel: ObservableObject {
    let notes: [Note]
    let notesSpacing: Double
    let ratio: Double
    let areNotesInset: Bool

    let clef: Clef
    let lineSpacing: Double
    let lineHeight: Double
    let extraLineWidth: Double

    init(notes: [Note], notesSpacing: Double, ratio: Double, areNotesInset: Bool) {
        self.notes = notes
        self.notesSpacing = notesSpacing
        self.ratio = ratio
        self.areNotesInset = areNotesInset

        self.clef = notes.first?.clef ?? .treble
        self.lineSpacing = 18 * ratio
        self.lineHeight = 2 * ratio
        self.extraLineWidth = 40 * ratio
    }

    var noteLineSpacing: Double {
        (lineSpacing + lineHeight) / 2
    }

    var calculatedHeight: Double {
        guard let minNote = notes.min(), let maxNote = notes.max() else { return 0 }
        var height = noteLineSpacing * 8 + lineHeight

        height += offsetWithWholeNote(from: minNote, comparingStaffPosition: .below, edgeCasePositions: -4)
        height += offsetWithWholeNote(from: maxNote, comparingStaffPosition: .above, edgeCasePositions: 4)

        return height
    }

    var calculatedOffsetFromCenter: Double {
        guard let minNote = notes.min(), let maxNote = notes.max() else { return 0 }
        var offset: Double = 0

        offset -= offsetWithWholeNote(from: minNote, comparingStaffPosition: .below, edgeCasePositions: -4)
        offset += offsetWithWholeNote(from: maxNote, comparingStaffPosition: .above, edgeCasePositions: 4)

        return offset / 2
    }

    func calculateExtraLinesOffset(note: Note) -> Double {
        let offset = noteLineSpacing * 6 + Double(note.extraLines - 1) * noteLineSpacing

        switch note.staffPosition {
        case .above:
            return -offset
        case .middle:
            return 0
        case .below:
            return offset
        }
    }

    func calculateWholeNoteOffset(note: Note) -> Double {
        Double(note.positionsFromCenterStaff) * -noteLineSpacing
    }

    private func offsetWithWholeNote(from note: Note, comparingStaffPosition: StaffPosition, edgeCasePositions: Int) -> Double {
        var offset: Double = 0
        if case comparingStaffPosition = note.staffPosition {
            offset += positiveOffsetFromPositions(from: note.positionsFromCenterStaff)
            offset += noteLineSpacing // addition for the whole note
        } else if note.positionsFromCenterStaff == edgeCasePositions {
            offset += noteLineSpacing // addition for the whole note
        }
        return offset
    }

    private func positiveOffsetFromPositions(from positionsFromCenterStaff: Int) -> Double {
        let positionsFromTopBottomStaff = abs(positionsFromCenterStaff) - 4
        return Double(positionsFromTopBottomStaff) * noteLineSpacing
    }
}

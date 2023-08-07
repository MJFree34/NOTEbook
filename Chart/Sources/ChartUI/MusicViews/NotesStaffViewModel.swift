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
    let lineSpacing: Double = 18
    let lineHeight: Double = 2
    let extraLineWidth: Double = 40

    var noteLineSpacing: Double {
        (lineSpacing + lineHeight) / 2
    }

    func calculateHeight(for notes: [Note]) -> Double {
        guard let minNote = notes.min(), let maxNote = notes.max() else { return 0 }
        var height = noteLineSpacing * 8 + lineHeight

        height += offsetWithWholeNote(from: minNote, comparingStaffPosition: .below, edgeCasePositions: -4)
        height += offsetWithWholeNote(from: maxNote, comparingStaffPosition: .above, edgeCasePositions: 4)

        return height
    }

    func calculateOffsetFromCenter(for notes: [Note]) -> Double {
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

//    func calculatedNotesPositionsOffset(positionsFromCenterStaff: Int, hasTwoNotes: Bool) -> Double {
//        // formula: offsetPositions = (positions + (positions < 0 ? -4 : 4) + (positions % 2 == 0 ? 0 : 1) * (positions < 0 ? -1 : 1)) / 2
//        guard abs(positionsFromCenterStaff) >= 4 else { return Double(positionsFromCenterStaff) }
//
//        let positionsWithFourAdded = positionsFromCenterStaff + (positionsFromCenterStaff < 0 ? -4 : 4)
//        let positionsRoundedUpToEven = positionsWithFourAdded + (positionsFromCenterStaff % 2 == 0 ? 0 : 1) * (positionsFromCenterStaff < 0 ? -1 : 1)
//        let positionsWithTwoNoteTopStaffOffset = positionsRoundedUpToEven + (positionsFromCenterStaff > 4 && hasTwoNotes && positionsFromCenterStaff % 2 != 0 ? -2 : 0)
//        let finalOffset = positionsWithTwoNoteTopStaffOffset / 2
//        return Double(finalOffset)
//    }
}

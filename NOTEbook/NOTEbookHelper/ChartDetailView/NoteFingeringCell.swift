//
//  NoteFingeringCell.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 12/30/22.
//  Copyright © 2022 Matthew Free. All rights reserved.
//

import ChartDomain
import ChartUI
import CommonUI
import SwiftUI

struct NoteFingeringCell: View {
    let notes: [Note]

    init(noteFingering: NoteFingering) {
        self.notes = noteFingering.notes
    }

    var body: some View {
        VStack(spacing: .base) {
            fingeringLetterView

            NotesStaffView(notes: notes, notesSpacing: 32, ratio: 0.5)
        }
        .padding(edges: .top, spacing: .small)
        .padding(edges: .bottom, spacing: .medium)
        .padding(edges: .horizontal, spacing: .small)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.theme(.aqua, .background))
                .shadow(color: .black.opacity(0.25), radius: Spacing.xSmall.rawValue, x: 0, y: Spacing.xSmall.rawValue)
        }
        .padding(edges: .horizontal, spacing: .xSmall)
    }

    private var fingeringLetterView: some View {
        HStack(spacing: .medium) {
            ForEach(notes) { note in
                letterView(note: note)
            }
        }
    }

    func letterView(note: Note) -> some View {
        HStack(spacing: 0) {
            Text(note.capitalizedLetter)
                .monospaced()
                .font(.largeTitle)

            if note.type == .flat || note.type == .sharp {
                NoteTypeView(type: note.type, isOffset: false, ratio: 0.5)
            }
        }
    }
}

struct NoteFingeringCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NoteFingeringCell(noteFingering: .singleNotePlaceholder)
                .frame(width: 160)

            NoteFingeringCell(noteFingering: .doubleNotePlaceholder)
                .frame(width: 160)
        }
        .previewComponent()
    }
}

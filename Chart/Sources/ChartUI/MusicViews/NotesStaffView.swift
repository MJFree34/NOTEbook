//
//  NotesStaffView.swift
//  ChartUI
//
//  Created by Matt Free on 8/3/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import SwiftUI

public struct NotesStaffView: View {
    private let notes: [Note]
    private let notesSpacing: Double
    private let areNotesInset: Bool

    private let clef: Clef

    private let viewModel = NotesStaffViewModel()

    public init(notes: [Note], notesSpacing: Double, areNotesInset: Bool) {
        self.notes = notes
        self.notesSpacing = notesSpacing
        self.areNotesInset = areNotesInset

        self.clef = notes.first?.clef ?? .treble
    }

    public var body: some View {
        ZStack {
            StaffView(spacing: viewModel.lineSpacing, lineHeight: viewModel.lineHeight)

            HStack {
                ClefView(clef: clef)

                Spacer()
            }

            fingeringNotesView
        }
        .offset(y: viewModel.calculateOffsetFromCenter(for: notes))
        .frame(height: viewModel.calculateHeight(for: notes))
    }

    private var fingeringNotesView: some View {
        HStack(spacing: 0) {
            if areNotesInset {
                Spacer(minLength: 0)
                Spacer(minLength: 0)
            }

            HStack(spacing: notesSpacing) {
                ForEach(notes) { note in
                    ZStack {
                        VStack(spacing: viewModel.lineSpacing) {
                            extraLinesView(note: note)
                                .offset(y: viewModel.calculateExtraLinesOffset(note: note))
                        }

                        accidentalNote(note: note)
                            .offset(y: viewModel.calculateWholeNoteOffset(note: note))
                    }
                }
            }

            if areNotesInset {
                Spacer(minLength: 0)
            }
        }
    }

    @ViewBuilder
    private func extraLinesView(note: Note) -> some View {
        if note.extraLines == 0 {
            Rectangle()
                .frame(width: viewModel.extraLineWidth)
                .hidden()
        } else {
            ForEach(0..<note.extraLines, id: \.self) { _ in
                Rectangle()
                    .frame(width: viewModel.extraLineWidth, height: viewModel.lineHeight)
            }
        }
    }

    private func accidentalNote(note: Note) -> some View {
        HStack(spacing: 0) {
            Group {
                switch note.type {
                case .flat:
                    NoteTypeView(type: .flat)
                case .natural:
                    EmptyView()
                case .sharp:
                    NoteTypeView(type: .sharp)
                }
            }
            .offset(x: -14)
            .frame(width: 0)

            WholeNoteView()
        }
    }
}

struct NotesStaffView_Previews: PreviewProvider {
    static var previews: some View {
        NotesStaffView(
            notes: [
                Note(letter: .b, type: .flat, octave: .three, clef: .treble),
                Note(letter: .c, type: .natural, octave: .five, clef: .treble),
                Note(letter: .c, type: .sharp, octave: .six, clef: .treble)
            ],
            notesSpacing: 40,
            areNotesInset: true
        )
        .previewComponent()
    }
}

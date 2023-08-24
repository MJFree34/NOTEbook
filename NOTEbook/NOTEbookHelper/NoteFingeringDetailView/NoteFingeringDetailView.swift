//
//  NoteFingeringDetailView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 12/29/22.
//  Copyright © 2022 Matthew Free. All rights reserved.
//

import ChartDomain
import ChartUI
import CommonUI
import SwiftUI

struct NoteFingeringDetailView: View, ActionableView {
    enum Action {
        case delete(at: IndexSet)
        case move(from: IndexSet, to: Int)
        case submit(at: Int?, fingering: any Fingering)
    }

    @Environment(\.editMode) private var editMode

    let noteFingering: NoteFingering
    let type: FingeringViewType

    var onAction: ActionClosure

    @State private var updateIndex: Int?
    @State private var addEditFingering: (any Fingering)?
    @State private var showAddEditFingeringView = false

    var body: some View {
        VStack {
            NoteFingeringCell(noteFingering: noteFingering)

            List {
                Group {
                    if noteFingering.fingerings.isEmpty {
                        Text("No fingering exists")
                    } else {
                        ForEach(Array(noteFingering.fingerings.enumerated()), id: \.offset) { index, fingering in
                            HStack {
                                VStack {
                                    Image(systemName: "\(index + 1).square")
                                    Spacer()
                                }

                                FingeringView(type: type, fingering: .constant(fingering))
                                    .allowsHitTesting(false)

                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if editMode?.wrappedValue.isEditing == true {
                                    updateIndex = index
                                    addEditFingering = fingering
                                    showAddEditFingeringView = true
                                }
                            }
                            .accessibilityAddTraits(editMode?.wrappedValue.isEditing == true ? .isButton : .isImage)
                        }
                        .onMove { fromOffsets, toIndex in
                            onAction?(.move(from: fromOffsets, to: toIndex))
                        }
                        .onDelete { atOffsets in
                            onAction?(.delete(at: atOffsets))
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
        }
        .padding(edges: .horizontal, spacing: .base)
        .background(theme: .aqua)
        .sheet(isPresented: $showAddEditFingeringView) {
            AddEditFingeringView(type: type, fingering: addEditFingering) { action in
                switch action {
                case .submitFingering(let fingering):
                    onAction?(.submit(at: updateIndex, fingering: fingering))
                    updateIndex = nil
                    addEditFingering = nil
                }
            }
            .interactiveDismissDisabled()
        }
        .toolbar {
            ToolbarItem(id: "Edit", placement: .navigationBarTrailing) {
                Button {
                    if editMode?.wrappedValue.isEditing == true {
                        editMode?.wrappedValue = EditMode.inactive
                    } else {
                        editMode?.wrappedValue = EditMode.active
                    }
                } label: {
                    if editMode?.wrappedValue.isEditing == true {
                        Text("Done")
                    } else {
                        Image(systemName: "pencil")
                    }
                }
            }

            ToolbarItem(id: "Add", placement: .bottomBar) {
                if editMode?.wrappedValue.isEditing == true {
                    Button {
                        showAddEditFingeringView = true
                    } label: {
                        Text("Add Fingering")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TintedNavigationStack {
            NoteFingeringDetailView(
                noteFingering: NoteFingering(
                    notes: [
                        Note(letter: .c, type: .natural, octave: .four, clef: .treble)
                    ],
                    fingerings: [
                        KeysFingering.emptyPlaceholder,
                        KeysFingering.fullPlaceholder
                    ]
                ),
                type: .threeValve,
                onAction: nil
            )
        }
    }
}

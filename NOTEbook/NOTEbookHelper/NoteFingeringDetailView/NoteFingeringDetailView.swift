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
        case update(at: Int, fingering: any Fingering)
        case add(fingering: any Fingering)
    }

    @Environment(\.editMode) private var editMode

    let noteFingering: NoteFingering
    let type: FingeringViewType

    var onAction: ActionClosure

    @State private var updateIndex: Int?
    @State private var editKeysFingering: KeysFingering?
    @State private var editKeysTriggersFingering: KeysTriggersFingering?
    @State private var editPositionFingering: PositionFingering?
    @State private var editPositionTriggersFingering: PositionTriggersFingering?
    @State private var showAddFingeringView = false

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
                                    if let editKeysFingering = fingering as? KeysFingering {
                                        self.editKeysFingering = editKeysFingering
                                    } else if let editKeysTriggersFingering = fingering as? KeysTriggersFingering {
                                        self.editKeysTriggersFingering = editKeysTriggersFingering
                                    } else if let editPositionFingering = fingering as? PositionFingering {
                                        self.editPositionFingering = editPositionFingering
                                    } else if let editPositionTriggersFingering = fingering as? PositionTriggersFingering {
                                        self.editPositionTriggersFingering = editPositionTriggersFingering
                                    } else {
                                        updateIndex = nil
                                    }
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
        .sheet(isPresented: $showAddFingeringView) {
            AddEditFingeringView(type: type) { action in
                switch action {
                case .submitFingering(let fingering):
                    onAction?(.add(fingering: fingering))
                }
            }
            .interactiveDismissDisabled()
        }
        .sheet(item: $editKeysFingering) { editFingering in
            addEditFingeringView(editFingering: editFingering)
        }
        .sheet(item: $editKeysTriggersFingering) { editFingering in
            addEditFingeringView(editFingering: editFingering)
        }
        .sheet(item: $editPositionFingering) { editFingering in
            addEditFingeringView(editFingering: editFingering)
        }
        .sheet(item: $editPositionTriggersFingering) { editFingering in
            addEditFingeringView(editFingering: editFingering)
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
                        showAddFingeringView = true
                    } label: {
                        Text("Add Fingering")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }

    private func addEditFingeringView(editFingering: any Fingering) -> some View {
        AddEditFingeringView(type: type, fingering: editFingering) { action in
            switch action {
            case .submitFingering(let fingering):
                if let updateIndex {
                    onAction?(.update(at: updateIndex, fingering: fingering))
                    self.updateIndex = nil
                }
            }
        }
        .interactiveDismissDisabled()
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

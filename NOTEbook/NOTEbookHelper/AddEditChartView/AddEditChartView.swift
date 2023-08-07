//
//  AddEditChartView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 1/2/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import ChartUI
import CommonUI
import SwiftUI

struct AddEditChartView: View, ActionableView {
    enum Action {
        case submitChart(FingeringChart)
    }

    private enum Mode {
        case update
        case add
    }

    @Environment(\.dismiss) private var dismiss

    var onAction: ActionClosure

    @StateObject private var viewModel: AddEditChartViewModel

    private let mode: Mode

    private let staffLineSpacing = 18.0
    private let staffLineHeight = 2.0
    private let extraStaffLineWidth = 40.0
    private let noteLabelRectSize = 60.0

    private var isFilledOut: Bool {
        !viewModel.name.isEmpty && !viewModel.detailName.isEmpty && viewModel.clef != nil
    }

    init(chart: FingeringChart? = nil, onAction: ActionClosure) {
        self._viewModel = StateObject(wrappedValue: AddEditChartViewModel(chart: chart))
        self.onAction = onAction
        self.mode = chart == nil ? .add : .update
    }

    var body: some View {
        TintedNavigationView {
            Form {
                Group {
                    instrumentNameTextField
                    instrumentDetailNameTextField
                    clefPicker

                    if viewModel.clef != nil {
                        Section("Note Range") {
                            noteRangePicker
                                .padding(.vertical)
                        }
                    }
                }
                .listRowBackground(.theme(.aqua, .background))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    DismissButton(dismissAction: dismiss)
                }

                ToolbarItem(placement: .bottomBar) {
                    addEditButton
                }

                ToolbarItem(placement: .keyboard) {
                    addEditButton
                }
            }
            .navigationTitle("\(mode == .add ? "Add" : "Update") Chart")
            .navigationBarTitleDisplayMode(.inline)
            .background(theme: .aqua)
        }
    }

    private var instrumentNameTextField: some View {
        Section("Name") {
            TextField("Name", text: $viewModel.name, prompt: Text("Name"))
        }
    }

    private var instrumentDetailNameTextField: some View {
        Section("Detail Name") {
            TextField("Detail Name", text: $viewModel.detailName, prompt: Text("Detail Name"))
        }
    }

    private var clefPicker: some View {
        Section("Clef") {
            Picker("Clef", selection: $viewModel.clef) {
                Text("")
                    .tag(nil as Clef?)

                ForEach(Clef.allCases) { clef in
                    Text(clef.rawValue.capitalized)
                        .tag(clef as Clef?)
                }
            }
        }
    }

    @ViewBuilder
    private var noteRangePicker: some View {
        if let minNote = viewModel.minNote, let centerNote = viewModel.centerNote, let maxNote = viewModel.maxNote {
            VStack {
                HStack {
                    verticalStepper(
                        increment: viewModel.increment,
                        decrement: viewModel.decrement,
                        disableIncrement: viewModel.disableIncrement(),
                        disableDecrement: viewModel.disableDecrement()
                    )
                    .frame(width: noteLabelRectSize)

                    noteLabel(selection: .min, note: minNote)

                    Spacer()

                    noteLabel(selection: .center, note: centerNote)

                    Spacer()

                    noteLabel(selection: .max, note: maxNote)

                    Spacer()
                }

                Spacer(minLength: .large)

                NotesStaffView(notes: [minNote, centerNote, maxNote], notesSpacing: 40, areNotesInset: true)

                Spacer(minLength: .small)
            }
        } else {
            EmptyView()
        }
    }

    private func noteLabel(selection: AddEditChartViewModel.NoteRangeSelection, note: Note) -> some View {
        Button {
            viewModel.rangeSelectionTapped(selection)
        } label: {
            VStack {
                Text(selection.rawValue)
                    .font(.caption)

                Text(note.capitalizedLetter)
                    .font(.title)
            }
        }
        .frame(width: noteLabelRectSize, height: noteLabelRectSize)
        .buttonStyle(.plain)
        .foregroundColor(selection == viewModel.noteRangeSelection ? .theme(.aqua, .background) : .contrast(.foreground))
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(selection == viewModel.noteRangeSelection ? .theme(.aqua, .foreground) : .clear)
        )
    }

    private func verticalStepper(
        increment: @escaping () -> Void,
        decrement: @escaping () -> Void,
        disableIncrement: Bool,
        disableDecrement: Bool
    ) -> some View {
        VStack(spacing: 4) {
            Button {
                increment()
            } label: {
                Image(systemName: "chevron.up")
                    .padding(2)
            }
            .disabled(disableIncrement)

            Button {
                decrement()
            } label: {
                Image(systemName: "chevron.down")
                    .padding(2)
            }
            .disabled(disableDecrement)
        }
        .buttonStyle(.bordered)
    }

    private var addEditButton: some View {
        Button {
            onAction?(.submitChart(viewModel.createChart()))
            dismiss()
        } label: {
            Text("\(mode == .add ? "Add" : "Edit") \(viewModel.name.isEmpty ? "Chart" : viewModel.name)")
        }
        .buttonStyle(.bordered)
        .disabled(!isFilledOut)
    }
}

struct AddEditFingeringChartView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditChartView(onAction: nil)

        AddEditChartView(chart: .placeholder, onAction: nil)
    }
}

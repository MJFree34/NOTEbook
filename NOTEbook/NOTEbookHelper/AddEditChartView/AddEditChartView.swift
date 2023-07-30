//
//  AddEditChartView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 1/2/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
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
    private let staffWidth = 300.0
    private let staffLineHeight = 2.0
    private let extraStaffLineWidth = 40.0

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

    private var noteRangePicker: some View {
        VStack {
            if let minNote = viewModel.minNote, let centerNote = viewModel.centerNote, let maxNote = viewModel.maxNote, let clef = viewModel.clef {
                HStack {
                    noteLabel(selection: .min, note: minNote)

                    Spacer()

                    noteLabel(selection: .center, note: centerNote)

                    Spacer()

                    noteLabel(selection: .max, note: maxNote)

                    Spacer(minLength: 20)

                    verticalStepper(
                        increment: viewModel.increment,
                        decrement: viewModel.decrement,
                        disableIncrement: viewModel.disableIncrement(),
                        disableDecrement: viewModel.disableDecrement()
                    )
                }
                .padding(.horizontal)

                Spacer()

                ZStack {
                    staffLinesView

                    HStack {
                        clefView(clef: clef)
                            .frame(width: 60)

                        notesView
                    }
                }

                Spacer()
            }
        }
        .frame(minHeight: 480)
    }

    private func noteLabel(selection: AddEditChartViewModel.NoteRangeSelection, note: Note) -> some View {
        Button {
            viewModel.rangeSelectionTapped(selection)
        } label: {
            VStack {
                Text(selection.rawValue)
                    .font(.caption)

                Text(note.capitalizedLetter())
                    .font(.title)
            }
        }
        .frame(width: 60, height: 60)
        .buttonStyle(.plain)
        .foregroundColor(selection == viewModel.noteRangeSelection ? .theme(.aqua, .background) : .contrast(.foreground))
        .background(RoundedRectangle(cornerRadius: 5).fill(selection == viewModel.noteRangeSelection ? .theme(.aqua, .foreground) : .clear))
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

    private var staffLinesView: some View {
        VStack(spacing: staffLineSpacing) {
            ForEach(0..<5) { _ in
                Rectangle()
                    .frame(width: staffWidth, height: staffLineHeight)
            }
        }
    }

    @ViewBuilder
    private func clefView(clef: Clef) -> some View {
        if clef == .treble {
            Image("TrebleClef")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(height: 152)
                .offset(x: 6)
        } else {
            Image("BassClef")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)
                .offset(x: -6, y: -9)
        }
    }

    private var notesView: some View {
        HStack(spacing: 20) {
            Spacer()

            if let minNote = viewModel.minNote, let centerNote = viewModel.centerNote, let maxNote = viewModel.maxNote {
                noteView(note: minNote)

                Spacer()

                noteView(note: centerNote)

                Spacer()

                noteView(note: maxNote)
            }

            Spacer()
        }
    }

    @ViewBuilder
    private func noteView(note: Note) -> some View {
        ZStack {
            wholeNoteView

            if note.positionsFromCenterStaff() < -5 || note.positionsFromCenterStaff() > 5 {
                let extraLines = abs(note.positionsFromCenterStaff()) / 2 - 2

                VStack(spacing: staffLineSpacing) {
                    ForEach(0..<extraLines, id: \.self) { _ in
                        Rectangle()
                            .frame(width: extraStaffLineWidth, height: staffLineHeight)
                    }
                }
                .offset(y: viewModel.calculatedExtraLinesOffset(positionsFromCenterStaff: note.positionsFromCenterStaff(), extraLines: extraLines))
            } else {
                Rectangle()
                    .frame(width: extraStaffLineWidth, height: staffLineHeight)
                    .hidden()
            }
        }
        .offset(y: Double(note.positionsFromCenterStaff()) * -viewModel.noteLineSpacing)
    }

    private var wholeNoteView: some View {
        Image("WholeNote")
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(height: 20)
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

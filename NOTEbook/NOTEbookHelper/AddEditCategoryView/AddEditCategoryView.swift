//
//  AddEditCategoryView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 1/1/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

struct AddEditCategoryView: View, ActionableView {
    enum Action {
        case submitCategory(ChartCategory)
    }

    private enum Mode {
        case add
        case update
    }

    @Environment(\.dismiss) private var dismiss

    private var id = UUID()
    @State private var section: ChartSection?
    @State private var name = ""
    private var fingeringCharts: [FingeringChart] = []

    private let mode: Mode

    var onAction: ActionClosure

    private var isFilledOut: Bool {
        !name.isEmpty && section != nil
    }

    init(category: ChartCategory? = nil, onAction: ActionClosure) {
        if let category {
            self.id = category.id
            self._section = State(initialValue: category.section)
            self._name = State(initialValue: category.name)
            self.fingeringCharts = category.fingeringCharts
        }

        self.onAction = onAction
        self.mode = category == nil ? .add : .update
    }

    var body: some View {
        TintedNavigationView {
            Form {
                Group {
                    nameTextField
                    sectionPicker
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
            .navigationTitle("\(mode == .add ? "Add" : "Edit") Category")
            .navigationBarTitleDisplayMode(.inline)
            .background(theme: .aqua)
        }
    }

    private var nameTextField: some View {
        Section("Name") {
            TextField("Name", text: $name, prompt: Text("Name"))
        }
    }

    private var sectionPicker: some View {
        Section("Section") {
            Picker("Section", selection: $section) {
                Text("")
                    .tag(nil as ChartSection?)

                ForEach(ChartSection.allCases) { section in
                    Text(section.rawValue)
                        .tag(section as ChartSection?)
                }
            }
        }
    }

    private var addEditButton: some View {
        Button {
            if let section {
                let newCategory = ChartCategory(id: id, name: name, section: section, fingeringCharts: fingeringCharts)
                onAction?(.submitCategory(newCategory))
            }
            dismiss()
        } label: {
            Text("\(mode == .add ? "Add" : "Edit") \(name.isEmpty ? "Category" : name)")
        }
        .buttonStyle(.bordered)
        .disabled(!isFilledOut)
    }
}

struct AddEditCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditCategoryView(onAction: nil)

        AddEditCategoryView(category: .placeholder, onAction: nil)
    }
}

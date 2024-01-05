//
//  CategoriesListView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/21/22.
//  Copyright © 2022 Matthew Free. All rights reserved.
//

import ChartDomain
import ChartUI
import CommonUI
import SwiftUI

struct CategoriesListView: View {
    private enum SheetType: Identifiable {
        case addCategory
        case editCategory(ChartCategory)
        case addChart(inParentWith: UUID)
        case editChart(inParentWith: UUID, chart: FingeringChart)

        var id: String {
            switch self {
            case .addCategory:
                return "AddCategory"
            case .editCategory:
                return "EditCategory"
            case .addChart:
                return "AddChart"
            case .editChart:
                return "EditChart"
            }
        }
    }

    @StateObject private var viewModel = CategoriesListViewModel()

    @State private var editMode = EditMode.inactive
    @State private var currentSheet: SheetType?

    var body: some View {
        TintedNavigationSplitView {
            content
                .sheet(item: $currentSheet) { addSheet in
                    Group {
                        switch addSheet {
                        case .addCategory:
                            AddEditCategoryView { [weak viewModel] action in
                                switch action {
                                case .submitCategory(let newCategory):
                                    viewModel?.addCategory(newCategory)
                                }
                            }
                        case .editCategory(let initialCategory):
                            AddEditCategoryView(category: initialCategory) { [weak viewModel] action in
                                switch action {
                                case .submitCategory(let updatedCategory):
                                    viewModel?.updateCategory(updatedCategory)
                                }
                            }
                        case .addChart(let parentCategoryId):
                            AddEditChartView { [weak viewModel] action in
                                switch action {
                                case .submitChart(let newChart):
                                    viewModel?.addChart(inParentWith: parentCategoryId, chart: newChart)
                                }
                            }
                        case let .editChart(parentCategoryId, initialChart):
                            AddEditChartView(chart: initialChart) { [weak viewModel] action in
                                switch action {
                                case .submitChart(let updatedChart):
                                    viewModel?.updateChart(inParentWith: parentCategoryId, chart: updatedChart)
                                }
                            }
                        }
                    }
                    .interactiveDismissDisabled()
                }
                .toolbar {
                    ToolbarItem(id: "edit", placement: .navigationBarLeading) {
                        EditButton()
                            .disabled(viewModel.screenState == .loading)
                    }

                    ToolbarItem(id: "share", placement: .navigationBarTrailing) {
                        ShareLink(item: viewModel.chartsURL)
                            .disabled(viewModel.screenState == .loading)
                    }

                    ToolbarItem(id: "add", placement: .navigationBarTrailing) {
                        addButton
                            .disabled(viewModel.screenState == .loading)
                    }
                }
                .onAppear {
                    viewModel.start()
                }
                .navigationTitle("Instruments")
//                .background(theme: .aqua)
                .environment(\.editMode, $editMode)
                .tint(.theme(.aqua, .foreground))
//        } content: {

        } detail: {

        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.screenState {
        case .loading:
            ProgressView()
        case .loaded:
            chartSections
        case .error(let error):
            ChartErrorStateView(error: error)
        }
    }

    private var chartSections: some View {
        List {
            ForEach(ChartSection.allCases) { section in
                let sectionExpandedBinding = Binding {
                    viewModel.userPreferences.sectionsExpanded[section.rawValue] ?? false
                } set: { newValue in
                    viewModel.userPreferences.sectionsExpanded[section.rawValue] = newValue
                }

                Section {
                    if sectionExpandedBinding.wrappedValue {
                        chartCategories(in: section)
                    } else {
                        Divider()
                    }
                } header: {
                    CollapsingRow(title: section.rawValue, isExpanded: sectionExpandedBinding)
                        .font(.title3)
                        .bold()
                }
                .foregroundColor(.theme(.aqua, .foreground))
            }
//            .listRowBackground(.theme(.aqua, .background))
        }
    }

    private func chartCategories(in section: ChartSection) -> some View {
        ForEach(viewModel.chartCategories.categories(in: section)) { category in
            let categoryExpandedBinding = Binding {
                viewModel.userPreferences.categoriesExpanded[category.name] ?? false
            } set: { newValue in
                viewModel.userPreferences.categoriesExpanded[category.name] = newValue
            }

            CollapsingRow(title: category.name, isExpanded: categoryExpandedBinding)
                .font(.headline)
                .deleteSwipeAction {
                    viewModel.deleteCategory(with: category.id)
                }
                .editSwipeAction {
                    currentSheet = .editCategory(category)
                }

            if categoryExpandedBinding.wrappedValue {
                fingeringCharts(in: category)
            }
        }
        .onMove { offsets, offset in
            viewModel.moveCategory(in: section, from: offsets, to: offset)
        }
        .onDelete { offsets in
            viewModel.deleteCategory(in: section, at: offsets)
        }
    }

    private func fingeringCharts(in category: ChartCategory) -> some View {
        ForEach(category.fingeringCharts) { fingeringChart in
            OverlayedNavigationLink {
                ChartDetailView(chart: fingeringChart) { [weak viewModel] action in
                    switch action {
                    case let .addFingering(noteFingeringId, fingering):
                        viewModel?.addFingering(
                            categoryId: category.id,
                            chartId: fingeringChart.id,
                            noteFingeringId: noteFingeringId,
                            fingering: fingering
                        )
                    case let .delete(noteFingeringId, atOffsets):
                        viewModel?.deleteFingeringInNoteFingering(
                            categoryId: category.id,
                            chartId: fingeringChart.id,
                            noteFingeringId: noteFingeringId,
                            at: atOffsets
                        )
                    case let .move(noteFingeringId, fromOffsets, toOffset):
                        viewModel?.moveFingeringInNoteFingering(
                            categoryId: category.id,
                            chartId: fingeringChart.id,
                            noteFingeringId: noteFingeringId,
                            from: fromOffsets,
                            to: toOffset
                        )
                    case .updateChart(let updatedChart):
                        viewModel?.updateChart(inParentWith: category.id, chart: updatedChart)
                    case let .updateFingering(noteFingeringId, index, fingering):
                        viewModel?.updateFingering(
                            categoryId: category.id,
                            chartId: fingeringChart.id,
                            noteFingeringId: noteFingeringId,
                            at: index,
                            fingering: fingering
                        )
                    }
                }
            } label: {
                TitleWithChevronRow(title: fingeringChart.instrument.name)
                    .padding(.leading)
                    .font(.callout)
                    .foregroundColor(.contrast(.foreground))
            }
            .deleteSwipeAction {
                viewModel.deleteChartInCategory(categoryId: category.id, chartId: fingeringChart.id)
            }
            .editSwipeAction {
                currentSheet = .editChart(inParentWith: category.id, chart: fingeringChart)
            }
        }
        .onMove { offsets, offset in
            viewModel.moveChartInCategory(with: category.id, from: offsets, to: offset)
        }
        .onDelete { offsets in
            viewModel.deleteChartInCategory(with: category.id, at: offsets)
        }
    }

    @ViewBuilder
    private var addButton: some View {
        switch editMode {
        case .inactive:
            addMenu
        default:
            EmptyView()
        }
    }

    private var addMenu: some View {
        Menu {
            Button {
                currentSheet = .addCategory
            } label: {
                Text("Add Chart Category")
            }

            addChartInCategoryMenu
        } label: {
            Label("Add", systemImage: "plus")
        }
    }

    private var addChartInCategoryMenu: some View {
        Menu {
            ForEach(ChartSection.allCases.flatMap { viewModel.chartCategories.categories(in: $0) }) { chartCategory in
                Button {
                    currentSheet = .addChart(inParentWith: chartCategory.id)
                } label: {
                    Text("Add in \(chartCategory.name)")
                }
            }
        } label: {
            Text("Add Chart in Category")
        }
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView()
    }
}

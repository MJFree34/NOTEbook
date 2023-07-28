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
    private enum SheetType: Int {
        case addChartCategory
        case addChart
    }

    private struct AddSheet: Identifiable {
        var type: SheetType
        var categoryToAddChartInName: String?

        var id: String { "\(categoryToAddChartInName ?? "") + \(type.rawValue)" }
    }

    @StateObject private var viewModel = CategoriesListViewModel()

    @State private var editMode = EditMode.inactive
    @State private var currentAddSheet: AddSheet?

    var body: some View {
        NavigationStack {
            content
                .sheet(item: $currentAddSheet) { addSheet in
//                  switch addSheet.type {
//                  case .addChartCategory:
//                      AddFingeringChartCategoryView()
//                          .interactiveDismissDisabled()
//                  case .addChart:
//                      AddFingeringChartView(categoryName: addSheet.categoryToAddChartInName!)
//                          .interactiveDismissDisabled()
//                  }
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
                .navigationTitle("NOTEbook Helper")
                .background(theme: .aqua)
                .environment(\.editMode, $editMode)
        }
        .tint(.theme(.aqua, .foreground))
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
                    }
                } header: {
                    CollapsingRow(title: section.rawValue, isExpanded: sectionExpandedBinding)
                        .font(.title3)
                        .bold()
                }
                .foregroundColor(.theme(.aqua, .foreground))
            }
            .listRowBackground(Color.theme(.aqua, .background))
        }
        .scrollContentBackground(.hidden)
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

            if categoryExpandedBinding.wrappedValue {
                fingeringCharts(in: category)
            }
        }
        .onMove { offsets, offset in
            moveCategory(in: section, from: offsets, to: offset)
        }
        .onDelete { offsets in
            deleteCategory(in: section, at: offsets)
        }
    }

    private func fingeringCharts(in category: ChartCategory) -> some View {
        ForEach(category.fingeringCharts) { fingeringChart in
            OverlayedNavigationLink {
//                FingeringChartDetailView(chart: fingeringChart, categoryName: chartCategory.name)
            } label: {
                TitleWithChevronRow(title: fingeringChart.instrument.name)
                    .padding(.leading)
                    .font(.callout)
                    .foregroundColor(.black)
            }
        }
        .onMove { offsets, offset in
            moveChartInCategory(with: category.id, from: offsets, to: offset)
        }
        .onDelete { offsets in
            deleteChartInCategory(with: category.id, at: offsets)
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
                currentAddSheet = AddSheet(type: .addChartCategory)
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
                    currentAddSheet = AddSheet(type: .addChart, categoryToAddChartInName: chartCategory.name)
                } label: {
                    Text("Add in \(chartCategory.name)")
                }
            }
        } label: {
            Text("Add Chart in Category")
        }
    }

    private func moveCategory(in section: ChartSection, from offsets: IndexSet, to offset: Int) {
        viewModel.moveCategory(in: section, from: offsets, to: offset)
    }

    private func moveChartInCategory(with categoryId: UUID, from offsets: IndexSet, to offset: Int) {
        viewModel.moveChartInCategory(with: categoryId, from: offsets, to: offset)
    }

    private func deleteCategory(in section: ChartSection, at offsets: IndexSet) {
        viewModel.deleteCategory(in: section, at: offsets)
    }

    private func deleteChartInCategory(with categoryId: UUID, at offsets: IndexSet) {
        viewModel.deleteChartInCategory(with: categoryId, at: offsets)
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView()
    }
}

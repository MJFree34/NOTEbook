//
//  CategoriesListView.swift
//  NOTEbook Helper
//
//  Created by Matt Free on 3/21/22.
//  Copyright © 2022 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

struct CategoriesListView: View, ActionableView {
    private enum SheetType: Int {
        case addChartCategory
        case addChart
    }

    private struct AddSheet: Identifiable {
        var type: SheetType
        var categoryToAddChartInName: String?

        var id: String { "\(categoryToAddChartInName ?? "") + \(type.rawValue)" }
    }

    enum Action {
        case start
    }

    @Binding var viewState: CategoriesListViewState
    var onAction: ActionClosure

    @State private var editMode = EditMode.inactive
    @State private var currentAddSheet: AddSheet?

    var body: some View {
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
                    EmptyView()
                }
                .toolbar {
                    ToolbarItem(id: "edit", placement: .navigationBarLeading) {
                        EditButton()
                            .disabled(viewState.screenState == .loading)
                    }

                    ToolbarItem(id: "share", placement: .navigationBarTrailing) {
                        ShareLink(item: viewState.chartsURL)
                            .disabled(viewState.screenState == .loading)
                    }

                    ToolbarItem(id: "add", placement: .navigationBarTrailing) {
                        addButton
                            .disabled(viewState.screenState == .loading)
                    }
                }
                .onAppear {
                    onAction?(.start)
                }
                .navigationTitle("NOTEbook Helper")
                .background(theme: .aqua)
                .scrollContentBackground(.hidden)
                .environment(\.editMode, $editMode)
    }

    @ViewBuilder
    private var content: some View {
        switch viewState.screenState {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .loaded:
            List(ChartSection.allCases) { section in
                chartSectionSection(section: section)
            }
        case .error(let error):
            Text("Error: \(error.localizedDescription)")
        }
    }

    @ViewBuilder
    func chartSectionSection(section: ChartSection) -> some View {
        Section(section.rawValue) {
            ForEach(viewState.chartCategories.categories(in: section)) { chartCategory in
                chartCategorySection(chartCategory: chartCategory)
            }
            .onMove { fromOffsets, toOffset in
                moveChartCategory(section: section, fromOffsets: fromOffsets, toOffset: toOffset)
            }
            .onDelete { offsets in
                deleteChartCategory(section: section, atOffsets: offsets)
            }
        }
//        .foregroundColor(Color("DarkAqua"))
//        .listRowBackground(Color("LightestAqua"))
        .headerProminence(.increased)
    }

    @ViewBuilder
    func chartCategorySection(chartCategory: ChartCategory) -> some View {
        Section {
            ForEach(chartCategory.fingeringCharts) { fingeringChart in
//                NavigationLink {
//                    FingeringChartDetailView(chart: fingeringChart, categoryName: chartCategory.name)
//                } label: {
//                    Text(fingeringChart.name)
//                        .padding(.leading)
//                        .foregroundColor(Color("Black"))
//                }
            }
            .onMove { fromOffsets, toOffset in
                moveFingeringChart(in: chartCategory.name, fromOffsets: fromOffsets, toOffset: toOffset)
            }
            .onDelete { offsets in
                deleteFingeringChart(in: chartCategory.name, atOffsets: offsets)
            }
        } header: {
            Group {
//                if editMode == .active {
//                    TextField("Category name", text: helperChartsController.bindingToCategoryName(categoryName: chartCategory.name)!)
//                } else {
//                    Text(chartCategory.name)
//                }
            }
            .bold()
//            .foregroundColor(Color("MediumAqua"))
        }
    }

    @ViewBuilder
    private var addButton: some View {
        switch editMode {
        case .inactive:
            Menu {
                Button {
                    currentAddSheet = AddSheet(type: .addChartCategory)
                } label: {
                    Text("Add Chart Category")
                }

                Menu {
//                    ForEach(ChartSection.allCases) { section in
//                        ForEach(helperChartsController.chartCategories(in: section)) { chartCategory in
//                            Button {
//                                currentAddSheet = AddSheet(type: .addChart, categoryToAddChartInName: chartCategory.name)
//                            } label: {
//                                Text("Add in \(chartCategory.name)")
//                            }
//                        }
//                    }
                } label: {
                    Text("Add Chart in Category")
                }
            } label: {
                Label("Add", systemImage: "plus")
            }
        default:
            EmptyView()
        }
    }

    private func moveFingeringChart(in chartCategoryName: String, fromOffsets: IndexSet, toOffset: Int) {
//        helperChartsController.moveFingeringChartInChartCategory(categoryName: chartCategoryName, fromOffsets: fromOffsets, toOffset: toOffset)
    }

    private func moveChartCategory(section: ChartSection, fromOffsets: IndexSet, toOffset: Int) {
//        helperChartsController.moveChartCategory(section: section, fromOffsets: fromOffsets, toOffset: toOffset)
    }

    private func deleteFingeringChart(in chartCategoryName: String, atOffsets offsets: IndexSet) {
//        helperChartsController.deleteFingeringChartInChartCategory(categoryName: chartCategoryName, atOffsets: offsets)
    }

    private func deleteChartCategory(section: ChartSection, atOffsets offsets: IndexSet) {
//        helperChartsController.deleteChartCategory(section: section, atOffsets: offsets)
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                CategoriesListView(viewState: .constant(.previewViewState()), onAction: nil)
            }
            
            NavigationView {
                CategoriesListView(viewState: .constant(.previewViewState(screenState: .loading)), onAction: nil)
            }
        }
    }
}

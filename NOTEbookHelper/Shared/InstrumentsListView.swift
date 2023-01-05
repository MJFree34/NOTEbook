//
//  ContentView.swift
//  Shared
//
//  Created by Matt Free on 3/21/22.
//

import SwiftUI

struct InstrumentsListView: View {
    private enum SheetType: Int {
        case addChartCategory
        case addChart
    }
    
    private struct AddSheet: Identifiable {
        var type: SheetType
        var categoryToAddChartInName: String?
        
        var id: String { "\(categoryToAddChartInName ?? "") + \(type.rawValue)" }
    }
    
    @EnvironmentObject private var helperChartsController: HelperChartsController
    
    @State private var editMode = EditMode.inactive
    @State private var chartCategoryMovingInsideName: String?
    
    @State private var currentAddSheet: AddSheet?
    
    var body: some View {
        NavigationStack {
            List(ChartSection.allCases) { section in
                chartSectionSection(section: section)
            }
            .sheet(item: $currentAddSheet) { addSheet in
                switch addSheet.type {
                case .addChartCategory:
                    AddFingeringChartCategoryView()
                case .addChart:
                    AddFingeringChartView(categoryName: addSheet.categoryToAddChartInName!)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton()
                }
            }
            .navigationTitle("NOTEbook Helper")
            .environment(\.editMode, $editMode)
        }
    }
    
    @ViewBuilder
    func chartSectionSection(section: ChartSection) -> some View {
        Section(section.rawValue) {
            ForEach(helperChartsController.chartCategories(in: section)) { chartCategory in
                chartCategorySection(chartCategory: chartCategory)
            }
            .onMove(perform: moveChartCategory)
        }
        .headerProminence(.increased)
    }
    
    @ViewBuilder
    func chartCategorySection(chartCategory: ChartCategory) -> some View {
        Section {
            ForEach(chartCategory.fingeringCharts) { fingeringChart in
                NavigationLink {
                    ChartDetailView(chart: fingeringChart, categoryName: chartCategory.name)
                } label: {
                    Text(fingeringChart.name)
                        .padding(.leading)
                }
            }
            .onMove { fromOffsets, toOffset in
                chartCategoryMovingInsideName = chartCategory.name
                moveFingeringChart(fromOffsets: fromOffsets, toOffset: toOffset)
                chartCategoryMovingInsideName = nil
            }
        } header: {
            Text(chartCategory.name)
                .bold()
        }
    }
    
    @ViewBuilder
    func addButton() -> some View {
        switch editMode {
        case .inactive:
            Menu {
                Button {
                    currentAddSheet = AddSheet(type: .addChartCategory)
                } label: {
                    Text("Add Chart Category")
                }
                
                Menu {
                    ForEach(ChartSection.allCases) { section in
                        ForEach(helperChartsController.chartCategories(in: section)) { chartCategory in
                            Button {
                                currentAddSheet = AddSheet(type: .addChart, categoryToAddChartInName: chartCategory.name)
                            } label: {
                                Text("Add in \(chartCategory.name)")
                            }
                        }
                    }
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
    
    private func moveFingeringChart(fromOffsets: IndexSet, toOffset: Int) {
        helperChartsController.moveFingeringChartInChartCategory(categoryName: chartCategoryMovingInsideName!, fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    private func moveChartCategory(fromOffsets: IndexSet, toOffset: Int) {
        helperChartsController.moveChartCategory(fromOffsets: fromOffsets, toOffset: toOffset)
    }
}

struct InstrumentsListView_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsListView()
            .environmentObject(HelperChartsController.shared)
    }
}

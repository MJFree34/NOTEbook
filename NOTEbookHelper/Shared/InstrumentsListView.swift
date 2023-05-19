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
    @State private var chartCategoryEditingInsideName: String?
    
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
                        .interactiveDismissDisabled()
                case .addChart:
                    AddFingeringChartView(categoryName: addSheet.categoryToAddChartInName!)
                        .interactiveDismissDisabled()
                }
            }
            .toolbar {
                ToolbarItem(id: "edit", placement: .navigationBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(id: "share", placement: .navigationBarTrailing) {
                    ShareLink(item: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(ChartsLoader.chartsFilename).json"))
                }
                
                ToolbarItem(id: "add", placement: .navigationBarTrailing) {
                    addButton()
                }
            }
            .navigationTitle("NOTEbook Helper")
            .scrollContentBackground(.hidden)
            .background(Color("LightestestAqua"))
            .environment(\.editMode, $editMode)
        }
        .tint(Color("DarkAqua"))
    }
    
    @ViewBuilder
    func chartSectionSection(section: ChartSection) -> some View {
        Section(section.rawValue) {
            ForEach(helperChartsController.chartCategories(in: section)) { chartCategory in
                chartCategorySection(chartCategory: chartCategory)
            }
            .onMove(perform: moveChartCategory)
            .onDelete(perform: deleteChartCategory)
        }
        .foregroundColor(Color("DarkAqua"))
        .listRowBackground(Color("LightestAqua"))
        .headerProminence(.increased)
    }
    
    @ViewBuilder
    func chartCategorySection(chartCategory: ChartCategory) -> some View {
        Section {
            ForEach(chartCategory.fingeringCharts) { fingeringChart in
                NavigationLink {
                    FingeringChartDetailView(chart: fingeringChart, categoryName: chartCategory.name)
                } label: {
                    Text(fingeringChart.name)
                        .padding(.leading)
                        .foregroundColor(Color("Black"))
                }
            }
            .onMove { fromOffsets, toOffset in
                chartCategoryEditingInsideName = chartCategory.name
                moveFingeringChart(fromOffsets: fromOffsets, toOffset: toOffset)
                chartCategoryEditingInsideName = nil
            }
            .onDelete { offsets in
                chartCategoryEditingInsideName = chartCategory.name
                deleteFingeringChart(atOffsets: offsets)
                chartCategoryEditingInsideName = nil
            }
        } header: {
            Group {
                if editMode == .active {
                    TextField("Category name", text: helperChartsController.bindingToCategoryName(categoryName: chartCategory.name)!)
                } else {
                    Text(chartCategory.name)
                }
            }
            .bold()
            .foregroundColor(Color("MediumAqua"))
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
        helperChartsController.moveFingeringChartInChartCategory(categoryName: chartCategoryEditingInsideName!, fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    private func moveChartCategory(fromOffsets: IndexSet, toOffset: Int) {
        helperChartsController.moveChartCategory(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    private func deleteFingeringChart(atOffsets offsets: IndexSet) {
        helperChartsController.deleteFingeringChartInChartCategory(categoryName: chartCategoryEditingInsideName!, atOffsets: offsets)
    }
    
    private func deleteChartCategory(atOffsets offsets: IndexSet) {
        helperChartsController.deleteChartCategory(atOffsets: offsets)
    }
}

struct InstrumentsListView_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsListView()
            .environmentObject(HelperChartsController.shared)
    }
}

//
//  ContentView.swift
//  Shared
//
//  Created by Matt Free on 3/21/22.
//

import SwiftUI

struct InstrumentsListView: View {
    @EnvironmentObject private var helperChartsController: HelperChartsController
    
    var body: some View {
        NavigationStack {
            List(ChartSection.allCases) { section in
                chartSectionSection(section: section)
            }
            .navigationDestination(for: FingeringChart.self) { fingeringChart in
                ChartDetailView(chart: fingeringChart)
            }
            .navigationTitle("NOTEbook Helper")
        }
    }
    
    @ViewBuilder
    func chartSectionSection(section: ChartSection) -> some View {
        Section(section.rawValue) {
            ForEach(helperChartsController.chartCategories(in: section)) { chartCategory in
                chartCategorySection(chartCategory: chartCategory)
            }
        }
        .headerProminence(.increased)
    }
    
    @ViewBuilder
    func chartCategorySection(chartCategory: ChartCategory) -> some View {
        Section {
            ForEach(chartCategory.fingeringCharts) { fingeringChart in
                NavigationLink(value: fingeringChart) {
                    Text(fingeringChart.name)
                        .padding(.leading)
                }
            }
        } header: {
            Text(chartCategory.name)
                .bold()
        }
    }
}

struct InstrumentsListView_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsListView()
            .environmentObject(HelperChartsController.shared)
    }
}

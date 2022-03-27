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
        NavigationView {
            List {
                ForEach(helperChartsController.chartCategories) { chartCategory in
                    Section(chartCategory.name) {
                        ForEach(chartCategory.fingeringCharts) { fingeringChart in
                            NavigationLink {
                                ChartDetailView(chart: fingeringChart)
                            } label: {
                                Text(fingeringChart.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("NOTEbook Helper")
        }
    }
}

struct InstrumentsListView_Previews: PreviewProvider {
    static var previews: some View {
        InstrumentsListView()
            .environmentObject(HelperChartsController.shared)
    }
}

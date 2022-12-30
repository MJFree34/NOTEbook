//
//  InstrumentDetailView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/26/22.
//

import SwiftUI

struct ChartDetailView: View {
    let chart: FingeringChart
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(chart.noteFingerings) { noteFingering in
                    NavigationLink(value: noteFingering) {
                        NoteCell(noteFingering: noteFingering)
                            .border(.black)
                    }
                }
            }
        }
        .navigationDestination(for: NoteFingering.self) { noteFingering in
            NoteFingeringDetailView(noteFingering: noteFingering, instrumentType: chart.instrument.type)
        }
        .tint(.black)
        .padding(.horizontal)
        .navigationTitle(chart.name)
    }
}

struct ChartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChartDetailView(chart: HelperChartsController.exampleChart)
        }
    }
}

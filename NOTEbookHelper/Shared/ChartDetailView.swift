//
//  InstrumentDetailView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/26/22.
//

import SwiftUI

struct ChartDetailView: View {
    @EnvironmentObject private var helperChartsController: HelperChartsController
    
    @Environment(\.dismiss) private var dismiss
    
    let chart: FingeringChart
    let categoryName: String
    
    @State private var showEditSheet = false
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(chart.noteFingerings, id: \.self) { noteFingering in
                    NavigationLink {
                        NoteFingeringDetailView(noteFingering: noteFingering, instrumentType: chart.instrument.type)
                    } label: {
                        NoteCell(noteFingering: noteFingering)
                            .border(.black)
                    }
                }
            }
        }
        .tint(.black)
        .padding(.horizontal)
        .sheet(isPresented: $showEditSheet) {
            dismiss()
        } content: {
            AddFingeringChartView(categoryName: categoryName, instrumentType: chart.instrument.type, minNote: chart.naturalNotes.first, maxNote: chart.naturalNotes.last)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showEditSheet = true
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .navigationTitle(chart.name)
    }
}

struct ChartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChartDetailView(chart: HelperChartsController.exampleChart, categoryName: HelperChartsController.exampleChartCategory.name)
        }
        .environmentObject(HelperChartsController.shared)
    }
}

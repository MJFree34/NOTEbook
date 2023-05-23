//
//  FingeringChartDetailView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/26/22.
//

import SwiftUI

struct FingeringChartDetailView: View {
    @EnvironmentObject private var helperChartsController: HelperChartsController
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var chart: FingeringChart
    
    let categoryName: String
    
    @State private var showEditSheet = false
    
    init(chart: FingeringChart, categoryName: String) {
        self._chart = HelperChartsController.shared.bindingToFingeringChart(in: categoryName, instrumentType: chart.instrument.type) ?? .constant(chart)
        self.categoryName = categoryName
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(chart.noteFingerings, id: \.self) { noteFingering in
                    let highlight = noteFingering.notes[0] == chart.centerNote
                    let isEmpty = noteFingering.fingerings.isEmpty
                    let color = (highlight ? Color("MediumRed") : Color("Black"))
                    let fadedColor = color.opacity(isEmpty ? 0.5 : 1)
                    NavigationLink {
                        NoteFingeringDetailView(noteFingering: noteFingering, color: color, categoryName: categoryName, instrumentType: chart.instrument.type)
                    } label: {
                        NoteCell(noteFingering: noteFingering, color: fadedColor)
                            .border(fadedColor)
                    }
                }
            }
        }
        .tint(.black)
        .padding(.horizontal)
        .sheet(isPresented: $showEditSheet) {
            AddFingeringChartView(categoryName: categoryName, instrumentType: chart.instrument.type, minNote: chart.naturalNotes.first, centerNote: chart.centerNote, maxNote: chart.naturalNotes.last)
                .interactiveDismissDisabled()
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
        .scrollContentBackground(.hidden)
        .background(Color("LightestestAqua"))
        .navigationTitle(chart.name)
    }
}

struct ChartDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FingeringChartDetailView(chart: HelperChartsController.exampleChart, categoryName: HelperChartsController.exampleChartCategory.name)
        }
        .environmentObject(HelperChartsController.shared)
    }
}

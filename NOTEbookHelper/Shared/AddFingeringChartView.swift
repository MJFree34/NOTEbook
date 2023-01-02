//
//  AddFingeringChartView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 1/2/23.
//

import SwiftUI

struct AddFingeringChartView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var helperChartsController: HelperChartsController
    
    var categoryName: String
    
    @State private var instrumentType: InstrumentType?
    
    var isFilledOut: Bool {
        instrumentType != nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Instrument") {
                    Picker("Instrument", selection: $instrumentType) {
                        Text("")
                            .tag(nil as InstrumentType?)
                        
                        ForEach(InstrumentType.allCases) { type in
                            Text(type.rawValue)
                                .tag(type as InstrumentType?)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                    }
                }
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        let instrument = Instrument(type: instrumentType!)
                        let chart = FingeringChart(instrument: instrument, centerNote: nil, naturalNotes: [], flatNotes: [], sharpNotes: [], noteFingerings: [])
                        
                        helperChartsController.addChart(in: categoryName, chart: chart)
                        dismiss()
                    } label: {
                        Text("Add \(instrumentType != nil ? instrumentType!.rawValue : "Chart")")
                    }
                    .buttonStyle(.bordered)
                    .disabled(!isFilledOut)
                }
            }
            .navigationTitle("Add Chart in \(categoryName)")
        }
    }
}

struct AddFingeringChartView_Previews: PreviewProvider {
    static var previews: some View {
        AddFingeringChartView(categoryName: HelperChartsController.exampleChartCategory.name)
            .environmentObject(HelperChartsController.shared)
    }
}

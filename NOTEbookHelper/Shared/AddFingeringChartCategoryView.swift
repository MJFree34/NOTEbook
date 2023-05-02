//
//  AddFingeringChartCategoryView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 1/1/23.
//

import SwiftUI

struct AddFingeringChartCategoryView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var helperChartsController: HelperChartsController
    
    @State private var section: ChartSection?
    @State private var name = ""
    
    var isFilledOut: Bool {
        !name.isEmpty && section != nil
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $name, prompt: Text("Name"))
                }
                
                Section("Section") {
                    Picker("Section", selection: $section) {
                        Text("")
                            .tag(nil as ChartSection?)
                        
                        ForEach(ChartSection.allCases) { section in
                            Text(section.rawValue)
                                .tag(section as ChartSection?)
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
                        helperChartsController.addChartCategory(category: ChartCategory(name: name, section: section!, fingeringCharts: []))
                        dismiss()
                    } label: {
                        Text("Add \(name.isEmpty ? "Category" : name)")
                    }
                    .buttonStyle(.bordered)
                    .disabled(!isFilledOut)
                }
            }
            .navigationTitle("Add Chart Category")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddFingeringChartGroupView_Previews: PreviewProvider {
    static var previews: some View {
        AddFingeringChartCategoryView()
            .environmentObject(HelperChartsController.shared)
    }
}

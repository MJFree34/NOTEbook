//
//  AddThreeFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/7/23.
//

import SwiftUI

struct AddThreeFingeringView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var helperChartsController: HelperChartsController
    
    let categoryName: String
    let instrumentType: InstrumentType
    let firstNote: Note
    
    @State private var key0 = false
    @State private var key1 = false
    @State private var key2 = false
    
    var body: some View {
        NavigationStack {
            HStack {
                Image("RoundFingering\(key0 ? "Full" : "Empty")1")
                    .onTapGesture {
                        key0.toggle()
                    }
                
                Image("RoundFingering\(key1 ? "Full" : "Empty")2")
                    .onTapGesture {
                        key1.toggle()
                    }
                
                Image("RoundFingering\(key2 ? "Full" : "Empty")3")
                    .onTapGesture {
                        key2.toggle()
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
                        let fingering = Fingering(keys: [key0, key1, key2])
                        helperChartsController.addFingering(in: categoryName, instrumentType: instrumentType, firstNote: firstNote, fingering: fingering)
                        
                        dismiss()
                    } label: {
                        Text("Add Fingering")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

struct AddThreeFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        AddThreeFingeringView(categoryName: HelperChartsController.exampleChartCategory.name, instrumentType: HelperChartsController.exampleChart.instrument.type, firstNote: HelperChartsController.exampleChart.noteFingerings[0].notes[0])
            .environmentObject(HelperChartsController.shared)
    }
}

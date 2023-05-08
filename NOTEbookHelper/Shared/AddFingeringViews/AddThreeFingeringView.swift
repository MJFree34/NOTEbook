//
//  AddThreeFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/7/23.
//

import SwiftUI

struct AddThreeFingeringView: View {
    private enum Mode {
        case update
        case add
    }
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var helperChartsController: HelperChartsController
    
    let categoryName: String
    let instrumentType: InstrumentType
    let firstNote: Note
    
    @State private var key0 = false
    @State private var key1 = false
    @State private var key2 = false
    
    private var mode: Mode
    private var fingeringIndex: Int?
    
    init(categoryName: String, instrumentType: InstrumentType, firstNote: Note) {
        self.mode = .add
        self.categoryName = categoryName
        self.instrumentType = instrumentType
        self.firstNote = firstNote
    }
    
    init(categoryName: String, instrumentType: InstrumentType, firstNote: Note, fingeringIndex: Int, fingering: Fingering) {
        self.mode = .update
        self.categoryName = categoryName
        self.instrumentType = instrumentType
        self.firstNote = firstNote
        self.fingeringIndex = fingeringIndex
        
        if let key0 = fingering.keys?[0], let key1 = fingering.keys?[1], let key2 = fingering.keys?[2] {
            self._key0 = .init(wrappedValue: key0)
            self._key1 = .init(wrappedValue: key1)
            self._key2 = .init(wrappedValue: key2)
        }
    }
    
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
                        switch mode {
                        case .add:
                            helperChartsController.addFingering(in: categoryName, instrumentType: instrumentType, firstNote: firstNote, fingering: fingering)
                        case .update:
                            helperChartsController.updateFingering(in: categoryName, instrumentType: instrumentType, firstNote: firstNote, fingeringIndex: fingeringIndex ?? 0, fingering: fingering)
                        }
                        
                        dismiss()
                    } label: {
                        Text("\(mode == .add ? "Add" : "Update") Fingering")
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

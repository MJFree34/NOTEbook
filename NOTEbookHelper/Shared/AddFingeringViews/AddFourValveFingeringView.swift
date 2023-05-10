//
//  AddFourValveFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/10/23.
//

import SwiftUI

struct AddFourValveFingeringView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var helperChartsController: HelperChartsController
    
    let isAdd: Bool
    
    @Binding var fingering: Fingering
    
    @State private var key1: Bool
    @State private var key2: Bool
    @State private var key3: Bool
    @State private var key4: Bool
    
    init(isAdd: Bool, fingering: Binding<Fingering>, key1: Bool, key2: Bool, key3: Bool, key4: Bool) {
        self.isAdd = isAdd
        self._fingering = fingering
        self._key1 = State(initialValue: key1)
        self._key2 = State(initialValue: key2)
        self._key3 = State(initialValue: key3)
        self._key4 = State(initialValue: key4)
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                Image("RoundFingering\(key1 ? "Full" : "Empty")1")
                    .onTapGesture {
                        key1.toggle()
                    }
                
                Image("RoundFingering\(key2 ? "Full" : "Empty")2")
                    .onTapGesture {
                        key2.toggle()
                    }
                
                Image("RoundFingering\(key3 ? "Full" : "Empty")3")
                    .onTapGesture {
                        key3.toggle()
                    }
                
                Image("RoundFingering\(key4 ? "Full" : "Empty")4")
                    .onTapGesture {
                        key4.toggle()
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
                        fingering.keys = [key1, key2, key3, key4]
                        dismiss()
                    } label: {
                        Text("\(isAdd ? "Add" : "Update") Fingering")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

struct AddFourValveFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddFourValveFingeringView(isAdd: true, fingering: .constant(Fingering()), key1: false, key2: false, key3: false, key4: false)
            
            AddFourValveFingeringView(isAdd: false, fingering: .constant(Fingering()), key1: true, key2: true, key3: true, key4: true)
        }
        .environmentObject(HelperChartsController.shared)
    }
}

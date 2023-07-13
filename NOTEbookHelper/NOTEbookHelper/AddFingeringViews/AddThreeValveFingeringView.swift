//
//  AddThreeValveFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/7/23.
//

import SwiftUI

struct AddThreeValveFingeringView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var helperChartsController: HelperChartsController
    
    let isAdd: Bool
    
    @Binding var fingering: Fingering
    
    @State private var key1: Bool
    @State private var key2: Bool
    @State private var key3: Bool
    
    init(isAdd: Bool, fingering: Binding<Fingering>, key1: Bool, key2: Bool, key3: Bool) {
        self.isAdd = isAdd
        self._fingering = fingering
        self._key1 = State(initialValue: key1)
        self._key2 = State(initialValue: key2)
        self._key3 = State(initialValue: key3)
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                Image("RoundFingering\(key1 ? "Full" : "Empty")1")
                    .renderingMode(.template)
                    .onTapGesture {
                        key1.toggle()
                    }
                
                Image("RoundFingering\(key2 ? "Full" : "Empty")2")
                    .renderingMode(.template)
                    .onTapGesture {
                        key2.toggle()
                    }
                
                Image("RoundFingering\(key3 ? "Full" : "Empty")3")
                    .renderingMode(.template)
                    .onTapGesture {
                        key3.toggle()
                    }
            }
            .foregroundColor(Color("Black"))
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
                        fingering.keys = [key1, key2, key3]
                        dismiss()
                    } label: {
                        Text("\(isAdd ? "Add" : "Update") Fingering")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LightestestAqua"))
        }
        .tint(Color("DarkAqua"))
    }
}

struct AddThreeValveFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddThreeValveFingeringView(isAdd: true, fingering: .constant(Fingering()), key1: false, key2: false, key3: false)
            
            AddThreeValveFingeringView(isAdd: false, fingering: .constant(Fingering()), key1: true, key2: true, key3: true)
        }
        .environmentObject(HelperChartsController.shared)
    }
}

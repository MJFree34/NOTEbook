//
//  AddPositionFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/10/23.
//

import SwiftUI

struct AddPositionFingeringView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var helperChartsController: HelperChartsController
    
    let isAdd: Bool
    
    @Binding var fingering: Fingering
    
    @State private var value: PositionValue
    @State private var type: NoteType
    
    var isFilledOut: Bool {
        value != .none
    }
    
    init(isAdd: Bool, fingering: Binding<Fingering>, value: PositionValue, type: NoteType) {
        self.isAdd = isAdd
        self._fingering = fingering
        self._value = State(initialValue: value)
        self._type = State(initialValue: type)
    }
    
    var body: some View {
        NavigationStack {
            HStack {
                Picker(selection: $type) {
                    Image("Flat")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 26)
                        .tag(NoteType.flat)
                    Text(" ")
                        .tag(NoteType.natural)
                    Image("Sharp")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 26)
                        .tag(NoteType.sharp)
                } label: {
                    Text("Type")
                }
                
                Picker(selection: $value) {
                    ForEach(PositionValue.allCases) { positionValue in
                        Text(positionValue.rawValue)
                            .font(.system(size: 30))
                            .tag(positionValue)
                    }
                } label: {
                    Text("Value")
                }

            }
            .pickerStyle(.wheel)
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
                        fingering.position = Position(value: value, type: type)
                        dismiss()
                    } label: {
                        Text("\(isAdd ? "Add" : "Update") Fingering")
                    }
                    .buttonStyle(.bordered)
                    .disabled(!isFilledOut)
                }
            }
        }
    }
}

struct AddPositionFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddPositionFingeringView(isAdd: false, fingering: .constant(Fingering()), value: .first, type: .flat)
            
            AddPositionFingeringView(isAdd: true, fingering: .constant(Fingering()), value: .none, type: .natural)
            
            AddPositionFingeringView(isAdd: false, fingering: .constant(Fingering()), value: .second, type: .sharp)
        }
        .environmentObject(HelperChartsController.shared)
    }
}

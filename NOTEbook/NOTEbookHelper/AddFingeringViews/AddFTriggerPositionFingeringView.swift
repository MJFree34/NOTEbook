//
//  AddFTriggerPositionFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/14/23.
//

import Common
import SwiftUI

struct AddFTriggerPositionFingeringView: View {
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var helperChartsController: HelperChartsController

    let isAdd: Bool

    @Binding var fingering: Fingering

    @State private var trigger: Bool
    @State private var value: Position.Value
    @State private var type: NoteType

    var isFilledOut: Bool {
        value != .none
    }

    init(isAdd: Bool, fingering: Binding<Fingering>, trigger: Bool, value: Position.Value, type: NoteType) {
        self.isAdd = isAdd
        self._fingering = fingering
        self._trigger = State(initialValue: trigger)
        self._value = State(initialValue: value)
        self._type = State(initialValue: type)
    }

    var body: some View {
        NavigationStack {
            HStack {
                Spacer()

                Image("FTrigger\(trigger ? "Full" : "Empty")")
                    .renderingMode(.template)
                    .onTapGesture {
                        trigger.toggle()
                    }

                Picker(selection: $type) {
                    Image("Flat")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 26)
                        .tag(NoteType.flat)
                    Text(" ")
                        .tag(NoteType.natural)
                    Image("Sharp")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 26)
                        .tag(NoteType.sharp)
                } label: {
                    Text("Type")
                }

                Picker(selection: $value) {
                    ForEach(Position.Value.allCases) { positionValue in
                        Text(positionValue.rawValue)
                            .font(.system(size: 30))
                            .tag(positionValue)
                    }
                } label: {
                    Text("Value")
                }
            }
            .foregroundColor(Color("Black"))
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
                        fingering.triggers = [trigger]
                        dismiss()
                    } label: {
                        Text("\(isAdd ? "Add" : "Update") Fingering")
                    }
                    .buttonStyle(.bordered)
                    .disabled(!isFilledOut)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("LightestestAqua"))
        }
        .tint(Color("DarkAqua"))
    }
}

struct AddFTriggerPositionFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddFTriggerPositionFingeringView(isAdd: false, fingering: .constant(Fingering()), trigger: false, value: .first, type: .flat)

            AddFTriggerPositionFingeringView(isAdd: true, fingering: .constant(Fingering()), trigger: false, value: .none, type: .natural)

            AddFTriggerPositionFingeringView(isAdd: false, fingering: .constant(Fingering()), trigger: true, value: .second, type: .sharp)
        }
        .environmentObject(HelperChartsController.shared)
    }
}

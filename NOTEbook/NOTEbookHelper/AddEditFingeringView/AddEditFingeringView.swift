//
//  AddEditFingeringView.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 5/17/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import ChartUI
import CommonUI
import SwiftUI

struct AddEditFingeringView: View, ActionableView {
    enum Action {
        case submitFingering(any Fingering)
    }

    private enum Mode {
        case add
        case update
    }

    @Environment(\.dismiss) private var dismiss

    private let type: FingeringViewType
    @State private var fingering: any Fingering

    private let mode: Mode

    var onAction: ActionClosure

    init(type: FingeringViewType, fingering: (any Fingering)? = nil, onAction: ActionClosure) {
        if let fingering {
            self._fingering = State(initialValue: fingering)
        } else {
            switch type {
            case .baritoneSaxophone, .clarinet, .flute, .fourValve, .saxophone, .threeValve:
                self._fingering = State(initialValue: KeysFingering.initial(for: type))
            case .bbTriggerThreeValve:
                self._fingering = State(initialValue: KeysTriggersFingering.initial(for: type))
            case .fTriggerPosition:
                self._fingering = State(initialValue: PositionFingering.initial(for: type))
            case .position:
                self._fingering = State(initialValue: PositionTriggersFingering.initial(for: type))
            }
        }

        self.type = type
        self.onAction = onAction
        self.mode = fingering == nil ? .add : .update
    }

    var body: some View {
        TintedNavigationView {
            FingeringView(type: type, fingering: $fingering, isInteractive: true)
                .background(theme: .aqua)
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
                            onAction?(.submitFingering(fingering))
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

struct AddEditFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        AddEditFingeringView(type: .threeValve, onAction: nil)
    }
}

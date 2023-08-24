//
//  PositionFingeringView.swift
//  ChartUI
//
//  Created by Matt Free on 5/10/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

struct PositionFingeringView: View {
    @Binding var fingering: PositionFingering
    let isInteractive: Bool

    var body: some View {
        PositionView(position: $fingering.position, isInteractive: isInteractive)
    }
}

struct PositionFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewBindingWrapper(wrappedBinding: PositionFingering(position: Position(value: .first, type: .natural))) { fingeringBinding in
                PositionFingeringView(fingering: fingeringBinding, isInteractive: true)
            }

            PreviewBindingWrapper(wrappedBinding: PositionFingering(position: Position(value: .fourth, type: .sharp))) { fingeringBinding in
                PositionFingeringView(fingering: fingeringBinding, isInteractive: false)
            }
        }
        .previewComponent()
    }
}

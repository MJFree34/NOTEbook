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

public struct PositionFingeringView: View {
    @Binding private var fingering: PositionFingering
    private var isInteractive: Bool

    public init(fingering: Binding<PositionFingering>, isInteractive: Bool = false) {
        self._fingering = fingering
        self.isInteractive = isInteractive
    }

    public var body: some View {
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
                PositionFingeringView(fingering: fingeringBinding)
            }
        }
        .previewComponent()
    }
}

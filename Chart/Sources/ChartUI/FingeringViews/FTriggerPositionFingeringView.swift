//
//  FTriggerPositionFingeringView.swift
//  ChartUI
//
//  Created by Matt Free on 5/14/23.
//  Copyright © 2022 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct FTriggerPositionFingeringView: View {
    @Binding private var fingering: PositionTriggersFingering
    private var isInteractive: Bool

    public init(fingering: Binding<PositionTriggersFingering>, isInteractive: Bool = false) {
        self._fingering = fingering
        self.isInteractive = isInteractive
    }

    public var body: some View {
        HStack {
            FingeringKeyImage(
                imageName: Constants.Trigger.f,
                isFull: $fingering.triggers[0],
                isInteractive: isInteractive,
                bundle: Bundle.module
            )

            PositionView(position: $fingering.position, isInteractive: isInteractive)
        }
    }
}

struct FTriggerPositionFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewBindingWrapper(wrappedBinding: PositionTriggersFingering.naturalPlaceholder) { fingeringBinding in
                FTriggerPositionFingeringView(fingering: fingeringBinding, isInteractive: true)
            }

            PreviewBindingWrapper(wrappedBinding: PositionTriggersFingering.sharpPlaceholder) { fingeringBinding in
                FTriggerPositionFingeringView(fingering: fingeringBinding)
            }
        }
        .previewComponent()
    }
}

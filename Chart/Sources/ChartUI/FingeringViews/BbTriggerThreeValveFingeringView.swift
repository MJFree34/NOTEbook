//
//  BbTriggerThreeValveFingeringView.swift
//  ChartUI
//
//  Created by Matt Free on 5/14/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct BbTriggerThreeValveFingeringView: View {
    @Binding private var fingering: KeysTriggersFingering
    private var isInteractive: Bool

    public init(fingering: Binding<KeysTriggersFingering>, isInteractive: Bool = false) {
        self._fingering = fingering
        self.isInteractive = isInteractive
    }

    public var body: some View {
        HStack {
            FingeringKeyImage(
                imageName: Constants.Trigger.bb,
                isFull: $fingering.triggers[0],
                isInteractive: isInteractive,
                bundle: Bundle.module
            )

            FingeringKeyImage(
                imageName: Constants.RoundFingering.one,
                isFull: $fingering.keys[0],
                isInteractive: isInteractive,
                bundle: Bundle.module
            )

            FingeringKeyImage(
                imageName: Constants.RoundFingering.two,
                isFull: $fingering.keys[1],
                isInteractive: isInteractive,
                bundle: Bundle.module
            )

            FingeringKeyImage(
                imageName: Constants.RoundFingering.three,
                isFull: $fingering.keys[2],
                isInteractive: isInteractive,
                bundle: Bundle.module
            )
        }
    }
}

struct BbTriggerThreeValveFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewBindingWrapper(wrappedBinding: KeysTriggersFingering.emptyPlaceholder) { fingeringBinding in
                BbTriggerThreeValveFingeringView(fingering: fingeringBinding, isInteractive: true)
            }

            PreviewBindingWrapper(wrappedBinding: KeysTriggersFingering.fullPlaceholder) { fingeringBinding in
                BbTriggerThreeValveFingeringView(fingering: fingeringBinding, isInteractive: true)
            }
        }
        .previewComponent()
    }
}

//
//  ThreeValveFingeringView.swift
//  ChartUI
//
//  Created by Matt Free on 11/25/22.
//  Copyright © 2022 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct ThreeValveFingeringView: View {
    @Binding private var fingering: KeysFingering
    private var isInteractive: Bool

    public init(fingering: Binding<KeysFingering>, isInteractive: Bool = false) {
        self._fingering = fingering
        self.isInteractive = isInteractive
    }

    public var body: some View {
        HStack {
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

struct ThreeValveFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewBindingWrapper(wrappedBinding: KeysFingering.emptyPlaceholder) { fingeringBinding in
                ThreeValveFingeringView(fingering: fingeringBinding, isInteractive: true)
            }

            PreviewBindingWrapper(wrappedBinding: KeysFingering.fullPlaceholder) { fingeringBinding in
                ThreeValveFingeringView(fingering: fingeringBinding, isInteractive: true)
            }
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
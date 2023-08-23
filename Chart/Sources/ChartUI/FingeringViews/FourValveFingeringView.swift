//
//  FourValveFingeringView.swift
//  ChartUI
//
//  Created by Matt Free on 5/10/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

struct FourValveFingeringView: View {
    @Binding var fingering: KeysFingering
    let isInteractive: Bool

    var body: some View {
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

            FingeringKeyImage(
                imageName: Constants.RoundFingering.four,
                isFull: $fingering.keys[3],
                isInteractive: isInteractive,
                bundle: Bundle.module
            )
        }
    }
}

struct FourValveFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewBindingWrapper(wrappedBinding: KeysFingering.emptyPlaceholder) { fingeringBinding in
                FourValveFingeringView(fingering: fingeringBinding, isInteractive: true)
            }

            PreviewBindingWrapper(wrappedBinding: KeysFingering.fullPlaceholder) { fingeringBinding in
                FourValveFingeringView(fingering: fingeringBinding, isInteractive: true)
            }
        }
        .previewComponent()
    }
}

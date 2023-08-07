//
//  FluteFingeringView.swift
//  ChartUI
//
//  Created by Matt Free on 5/14/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct FluteFingeringView: View {
    @Binding private var fingering: KeysFingering
    private var isInteractive: Bool

    public init(fingering: Binding<KeysFingering>, isInteractive: Bool = false) {
        self._fingering = fingering
        self.isInteractive = isInteractive
    }

    public var body: some View {
        ZStack(alignment: .bottom) {
            FingeringDoubleKeysImage(
                imageName: Constants.Flute.leverKeys,
                firstIsFull: $fingering.keys[7],
                secondIsFull: $fingering.keys[8],
                isInteractive: isInteractive,
                bundle: Bundle.module
            )
            .padding(.trailing, 74)
            .padding(.bottom, 6)

            HStack(alignment: .top, spacing: 0) {
                VStack(spacing: 2) {
                    HStack(spacing: 5) {
                        FingeringKeyImage(
                            imageName: Constants.Flute.circleKey,
                            isFull: $fingering.keys[0],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Flute.circleKey,
                            isFull: $fingering.keys[1],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Flute.circleKey,
                            isFull: $fingering.keys[2],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )
                    }

                    FingeringDoubleKeysImage(
                        imageName: Constants.Flute.thumbKeys,
                        firstIsFull: $fingering.keys[14],
                        secondIsFull: $fingering.keys[15],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )
                }

                VStack(spacing: -8) {
                    HStack(spacing: 5) {
                        FingeringKeyImage(
                            imageName: Constants.Flute.circleKey,
                            isFull: $fingering.keys[3],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Flute.circleKey,
                            isFull: $fingering.keys[4],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Flute.circleKey,
                            isFull: $fingering.keys[5],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )
                    }

                    HStack(spacing: 23) {
                        FingeringKeyImage(
                            imageName: Constants.Flute.trillKey,
                            isFull: $fingering.keys[9],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Flute.trillKey,
                            isFull: $fingering.keys[10],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )
                    }
                }
                .padding(.leading, 20)

                FingeringKeyImage(
                    imageName: Constants.Flute.pinkyKey,
                    isFull: $fingering.keys[6],
                    isInteractive: isInteractive,
                    bundle: Bundle.module
                )
                .padding(.leading, 2)

                VStack(spacing: 3.5) {
                    FingeringKeyImage(
                        imageName: Constants.Flute.footKey2,
                        isFull: $fingering.keys[13],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )

                    FingeringKeyImage(
                        imageName: Constants.Flute.footKey2,
                        isFull: $fingering.keys[12],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )

                    FingeringKeyImage(
                        imageName: Constants.Flute.footKey1,
                        isFull: $fingering.keys[11],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )
                }
                .padding(.leading, 2)
            }
        }
    }
}

struct FluteFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewBindingWrapper(wrappedBinding: KeysFingering.emptyPlaceholder) { fingeringBinding in
                FluteFingeringView(fingering: fingeringBinding, isInteractive: true)
            }

            PreviewBindingWrapper(wrappedBinding: KeysFingering.fullPlaceholder) { fingeringBinding in
                FluteFingeringView(fingering: fingeringBinding, isInteractive: true)
            }
        }
        .previewComponent()
    }
}

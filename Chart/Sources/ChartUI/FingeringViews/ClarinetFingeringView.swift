//
//  ClarinetFingeringView.swift
//  ChartUI
//
//  Created by Matt Free on 5/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct ClarinetFingeringView: View {
    @Binding private var fingering: KeysFingering
    private var isInteractive: Bool

    public init(fingering: Binding<KeysFingering>, isInteractive: Bool = false) {
        self._fingering = fingering
        self.isInteractive = isInteractive
    }

    public var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 2) {
                FingeringKeyImage(
                    imageName: Constants.Clarinet.topLeverKey,
                    isFull: $fingering.keys[13],
                    isInteractive: isInteractive,
                    bundle: Bundle.module
                )
                .padding(.leading, 16)
                .padding(.top, 24)

                HStack(spacing: 12) {
                    HStack(spacing: 2) {
                        FingeringKeyImage(
                            imageName: Constants.Clarinet.topLeverKey,
                            isFull: $fingering.keys[14],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Clarinet.circleKey,
                            isFull: $fingering.keys[0],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )
                    }

                    FingeringKeyImage(
                        imageName: Constants.Clarinet.circleKey,
                        isFull: $fingering.keys[1],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )

                    FingeringKeyImage(
                        imageName: Constants.Clarinet.circleKey,
                        isFull: $fingering.keys[2],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )

                    FingeringKeyImage(
                        imageName: Constants.Clarinet.circleKey,
                        isFull: $fingering.keys[3],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )
                    .padding(.leading, 10)

                    FingeringKeyImage(
                        imageName: Constants.Clarinet.circleKey,
                        isFull: $fingering.keys[4],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )

                    FingeringKeyImage(
                        imageName: Constants.Clarinet.circleKey,
                        isFull: $fingering.keys[5],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )
                    .padding(.trailing, 26)
                }

                HStack(alignment: .bottom, spacing: 44) {
                    FingeringDoubleKeysImage(
                        imageName: Constants.Clarinet.thumbKeys,
                        firstIsFull: $fingering.keys[22],
                        secondIsFull: $fingering.keys[23],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )
                    .padding(.leading, 14)

                    HStack(alignment: .bottom, spacing: 0) {
                        FingeringKeyImage(
                            imageName: Constants.Clarinet.smallSideKey,
                            isFull: $fingering.keys[21],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Clarinet.smallSideKey,
                            isFull: $fingering.keys[20],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Clarinet.largeSideKey,
                            isFull: $fingering.keys[19],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Clarinet.largeSideKey,
                            isFull: $fingering.keys[18],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )
                    }
                }
            }

            HStack(alignment: .top, spacing: 32) {
                FingeringKeyImage(
                    imageName: Constants.Clarinet.thinRightLeverKey,
                    isFull: $fingering.keys[12],
                    isInteractive: isInteractive,
                    bundle: Bundle.module
                )
                FingeringKeyImage(
                    imageName: Constants.Clarinet.middleLeverKey,
                    isFull: $fingering.keys[11],
                    isInteractive: isInteractive,
                    bundle: Bundle.module
                )
            }
            .padding(.top, 28)
            .padding(.trailing, 142)

            HStack(spacing: 33) {
                FingeringKeyImage(
                    imageName: Constants.Clarinet.thinLeftLeverKey,
                    isFull: $fingering.keys[10],
                    isInteractive: isInteractive,
                    bundle: Bundle.module
                )

                HStack(spacing: 2) {
                    FingeringDoubleKeysImage(
                        imageName: Constants.Clarinet.bottomKeys,
                        firstIsFull: $fingering.keys[8],
                        secondIsFull: $fingering.keys[9],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )
                    FingeringDoubleKeysImage(
                        imageName: Constants.Clarinet.bottomKeys,
                        firstIsFull: $fingering.keys[6],
                        secondIsFull: $fingering.keys[7],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )
                }
            }
            .padding(.top, 44)

            HStack(alignment: .top, spacing: -8) {
                FingeringKeyImage(
                    imageName: Constants.Clarinet.triggerKey3,
                    isFull: $fingering.keys[17],
                    isInteractive: isInteractive,
                    bundle: Bundle.module
                )
                .padding(.top, 4)

                VStack(alignment: .trailing, spacing: 2) {
                    FingeringKeyImage(
                        imageName: Constants.Clarinet.triggerKey1,
                        isFull: $fingering.keys[15],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )

                    FingeringKeyImage(
                        imageName: Constants.Clarinet.triggerKey2,
                        isFull: $fingering.keys[16],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )
                    .padding(.trailing, 6)
                }
            }
            .padding(.trailing, 56)
        }
    }
}

struct ClarinetFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewBindingWrapper(wrappedBinding: KeysFingering.emptyPlaceholder) { fingeringBinding in
                ClarinetFingeringView(fingering: fingeringBinding, isInteractive: true)
            }

            PreviewBindingWrapper(wrappedBinding: KeysFingering.fullPlaceholder) { fingeringBinding in
                ClarinetFingeringView(fingering: fingeringBinding, isInteractive: true)
            }
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

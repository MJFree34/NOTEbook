//
//  BaritoneSaxophoneFingeringView.swift
//  ChartUI
//
//  Created by Matt Free on 5/17/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct BaritoneSaxophoneFingeringView: View {
    @Binding private var fingering: KeysFingering
    private var isInteractive: Bool

    public init(fingering: Binding<KeysFingering>, isInteractive: Bool = false) {
        self._fingering = fingering
        self.isInteractive = isInteractive
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom, spacing: 38) {
                    VStack(alignment: .leading, spacing: 2) {
                        FingeringKeyImage(
                            imageName: Constants.Saxophone.topLeverKey,
                            isFull: $fingering.keys[16],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )
                        .padding(.leading, 16)

                        VStack(alignment: .leading, spacing: -2) {
                            FingeringKeyImage(
                                imageName: Constants.Saxophone.topLeverKey,
                                isFull: $fingering.keys[15],
                                isInteractive: isInteractive,
                                bundle: Bundle.module
                            )

                            FingeringKeyImage(
                                imageName: Constants.Saxophone.topLeverKey,
                                isFull: $fingering.keys[14],
                                isInteractive: isInteractive,
                                bundle: Bundle.module
                            )
                            .padding(.leading, 10)
                        }
                    }

                    HStack(alignment: .bottom, spacing: -4) {
                        FingeringKeyImage(
                            imageName: Constants.Saxophone.upperLowKey,
                            isFull: $fingering.keys[20],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringDoubleKeysImage(
                            imageName: Constants.Saxophone.middleLowKeys,
                            firstIsFull: $fingering.keys[18],
                            secondIsFull: $fingering.keys[19],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )
                        .padding(.bottom, 2)

                        FingeringKeyImage(
                            imageName: Constants.Saxophone.bottomLowKey,
                            isFull: $fingering.keys[17],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )
                        .padding(.bottom, 4)
                    }
                }
                .padding(.leading, 18)

                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        FingeringKeyImage(
                            imageName: Constants.Saxophone.forkKey,
                            isFull: $fingering.keys[13],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Saxophone.circleKey,
                            isFull: $fingering.keys[0],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )
                    }

                    FingeringKeyImage(
                        imageName: Constants.Saxophone.circleKey,
                        isFull: $fingering.keys[1],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )

                    FingeringKeyImage(
                        imageName: Constants.Saxophone.circleKeyWithLine,
                        isFull: $fingering.keys[2],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )

                    FingeringKeyImage(
                        imageName: Constants.Saxophone.circleKey,
                        isFull: $fingering.keys[3],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )

                    FingeringKeyImage(
                        imageName: Constants.Saxophone.circleKey,
                        isFull: $fingering.keys[4],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )

                    FingeringKeyImage(
                        imageName: Constants.Saxophone.circleKey,
                        isFull: $fingering.keys[5],
                        isInteractive: isInteractive,
                        bundle: Bundle.module
                    )
                }

                HStack(alignment: .bottom, spacing: 71) {
                    HStack(spacing: -2) {
                        FingeringKeyImage(
                            imageName: Constants.Saxophone.octaveKey,
                            isFull: $fingering.keys[22],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )

                        FingeringKeyImage(
                            imageName: Constants.Saxophone.baritoneOctaveKey,
                            isFull: $fingering.keys[23],
                            isInteractive: isInteractive,
                            bundle: Bundle.module
                        )
                    }

                    HStack(alignment: .bottom, spacing: 12) {
                        HStack(spacing: 4) {
                            VStack(alignment: .trailing, spacing: 10) {
                                FingeringKeyImage(
                                    imageName: Constants.Saxophone.highFSharpKey,
                                    isFull: $fingering.keys[12],
                                    isInteractive: isInteractive,
                                    bundle: Bundle.module
                                )

                                HStack(spacing: 2) {
                                    FingeringKeyImage(
                                        imageName: Constants.Saxophone.largeSideKey,
                                        isFull: $fingering.keys[11],
                                        isInteractive: isInteractive,
                                        bundle: Bundle.module
                                    )

                                    FingeringKeyImage(
                                        imageName: Constants.Saxophone.smallSideKey,
                                        isFull: $fingering.keys[10],
                                        isInteractive: isInteractive,
                                        bundle: Bundle.module
                                    )

                                    FingeringKeyImage(
                                        imageName: Constants.Saxophone.smallSideKey,
                                        isFull: $fingering.keys[9],
                                        isInteractive: isInteractive,
                                        bundle: Bundle.module
                                    )
                                }
                            }

                            FingeringKeyImage(
                                imageName: Constants.Saxophone.chromaticFSharpKey,
                                isFull: $fingering.keys[8],
                                isInteractive: isInteractive,
                                bundle: Bundle.module
                            )
                        }

                        HStack(spacing: 2) {
                            FingeringKeyImage(
                                imageName: Constants.Saxophone.bottomKey2,
                                isFull: $fingering.keys[7],
                                isInteractive: isInteractive,
                                bundle: Bundle.module
                            )
                            FingeringKeyImage(
                                imageName: Constants.Saxophone.bottomKey1,
                                isFull: $fingering.keys[6],
                                isInteractive: isInteractive,
                                bundle: Bundle.module
                            )
                        }
                    }
                }
            }

            FingeringKeyImage(
                imageName: Constants.Saxophone.bisKey,
                isFull: $fingering.keys[21],
                isInteractive: isInteractive,
                bundle: Bundle.module
            )
            .padding(.top, 68)
            .padding(.leading, 48)
        }
    }
}

struct BaritoneSaxophoneFingeringView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PreviewBindingWrapper(wrappedBinding: KeysFingering.emptyPlaceholder) { fingeringBinding in
                BaritoneSaxophoneFingeringView(fingering: fingeringBinding, isInteractive: true)
            }

            PreviewBindingWrapper(wrappedBinding: KeysFingering.fullPlaceholder) { fingeringBinding in
                BaritoneSaxophoneFingeringView(fingering: fingeringBinding, isInteractive: true)
            }
        }
        .previewComponent()
    }
}

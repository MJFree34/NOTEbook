//
//  FingeringView.swift
//  ChartUI
//
//  Created by Matt Free on 8/22/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import CommonUI
import SwiftUI

public struct FingeringView: View {
    private let type: FingeringViewType
    @Binding private var fingering: any Fingering
    private let isInteractive: Bool

    public init(type: FingeringViewType, fingering: Binding<any Fingering>, isInteractive: Bool = false) {
        self.type = type
        self._fingering = fingering
        self.isInteractive = isInteractive
    }

    public var body: some View {
        if let keysFingering = fingering as? KeysFingering {
            let keysFingeringBinding = Binding {
                keysFingering
            } set: { newValue, _ in
                fingering = newValue
            }

            switch type {
            case .baritoneSaxophone:
                BaritoneSaxophoneFingeringView(fingering: keysFingeringBinding, isInteractive: isInteractive)
            case .clarinet:
                ClarinetFingeringView(fingering: keysFingeringBinding, isInteractive: isInteractive)
            case .flute:
                FluteFingeringView(fingering: keysFingeringBinding, isInteractive: isInteractive)
            case .fourValve:
                FourValveFingeringView(fingering: keysFingeringBinding, isInteractive: isInteractive)
            case .saxophone:
                SaxophoneFingeringView(fingering: keysFingeringBinding, isInteractive: isInteractive)
            case .threeValve:
                ThreeValveFingeringView(fingering: keysFingeringBinding, isInteractive: isInteractive)
            default:
                errorView
            }
        } else if let keysTriggersFingering = fingering as? KeysTriggersFingering {
            let keysTriggersFingeringBinding = Binding {
                keysTriggersFingering
            } set: { newValue, _ in
                fingering = newValue
            }

            switch type {
            case .bbTriggerThreeValve:
                BbTriggerThreeValveFingeringView(fingering: keysTriggersFingeringBinding, isInteractive: isInteractive)
            default:
                errorView
            }
        } else if let positionFingering = fingering as? PositionFingering {
            let positionFingeringBinding = Binding {
                positionFingering
            } set: { newValue, _ in
                fingering = newValue
            }

            switch type {
            case .position:
                PositionFingeringView(fingering: positionFingeringBinding, isInteractive: isInteractive)
            default:
                errorView
            }
        } else if let positionTriggersFingering = fingering as? PositionTriggersFingering {
            let positionTriggersFingeringBinding = Binding {
                positionTriggersFingering
            } set: { newValue, _ in
                fingering = newValue
            }

            switch type {
            case .position:
                FTriggerPositionFingeringView(fingering: positionTriggersFingeringBinding, isInteractive: isInteractive)
            default:
                errorView
            }
        } else {
            errorView
        }
    }

    private var errorView: some View {
        Text("Fingering Error")
            .foregroundColor(.red)
    }
}

struct FingeringView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewBindingWrapper(wrappedBinding: KeysFingering.emptyPlaceholder as any Fingering) { fingeringBinding in
            FingeringView(type: .threeValve, fingering: fingeringBinding)
                .previewComponent()
        }
    }
}

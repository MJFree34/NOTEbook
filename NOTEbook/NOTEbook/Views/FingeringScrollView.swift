//
//  FingeringScrollView.swift
//  NOTEbook
//
//  Created by Matt Free on 9/6/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FingeringScrollView: UIView {
    private lazy var optionalLabel = OptionalLabel(large: true)
    
    private var fingering: Fingering?
    
    init(fingering: Fingering?) {
        self.fingering = fingering
        
        super.init(frame: .zero)
        
        addSubview(optionalLabel)
        
        NSLayoutConstraint.activate([
            optionalLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            optionalLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        let currentInstrumentType = ChartsController.shared.currentChart.instrument.type
        
        if let fingering = fingering {
            let fingeringView: FingeringView
            
            var yConstant: CGFloat = 0
            
            switch currentInstrumentType {
            case .cFlute:
                fingeringView = FluteFingeringView(fingering: fingering, ratio: 1)
                yConstant = -5
            case .bbSopranoClarinet:
                fingeringView = ClarinetFingeringView(fingering: fingering, ratio: 0.75)
                yConstant = -15
            case .ebAltoSaxophone, .bbTenorSaxophone:
                fingeringView = SaxophoneFingeringView(fingering: fingering, ratio: 0.70)
            case .ebBaritoneSaxophone:
                fingeringView = BaritoneSaxophoneFingeringView(fingering: fingering, ratio: 0.70)
            case .bbTrumpet, .fMellophone, .fSingleFrenchHorn, .bbBaritoneHorn, .threeValveBBbTuba, .threeValveEbTuba:
                fingeringView = ThreeValveFingeringView(fingering: fingering, ratio: 1)
            case .fBbDoubleFrenchHorn:
                fingeringView = BbTriggerThreeValveFingeringView(fingering: fingering, ratio: 1)
            case .fourValveBbEuphoniumCompensating, .fourValveBbEuphoniumNonCompensating:
                fingeringView = FourValveFingeringView(fingering: fingering, ratio: 1)
            case .bbTenorTrombone:
                fingeringView = PositionFingeringView(fingering: fingering, ratio: 1)
            case .fTriggerBbTenorTrombone:
                fingeringView = FTriggerPositionFingeringView(fingering: fingering, ratio: 1)
            }
            
            fingeringView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(fingeringView)
            
            NSLayoutConstraint.activate([
                fingeringView.centerXAnchor.constraint(equalTo: centerXAnchor),
                fingeringView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: yConstant)
            ])
        } else {
            optionalLabel.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

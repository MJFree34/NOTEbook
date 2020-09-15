//
//  FingeringScrollingView.swift
//  NOTEbook
//
//  Created by Matt Free on 9/6/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FingeringScrollingView: UIView {
    private lazy var optionalLabel: UILabel = {
        var lab = UILabel()
        lab.font = UIFont.preferredFont(forTextStyle: .title1)
        lab.textAlignment = .center
        lab.textColor = UIColor(named: "Black")
        lab.isHidden = true
        lab.text = "N/A"
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        return lab
    }()
    
    var fingering: Fingering
    
    init(fingering: Fingering) {
        self.fingering = fingering
        
        super.init(frame: .zero)
        
        addSubview(optionalLabel)
        
        NSLayoutConstraint.activate([
            optionalLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            optionalLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        let currentInstrumentType = ChartsController.shared.currentChart.instrument.type
        
        if fingering.keys == nil {
            optionalLabel.isHidden = false
        } else {
            let fingeringView: FingeringView
            var yConstant: CGFloat = 0
            
            switch currentInstrumentType {
            case .trumpet, .baritoneTC, .baritoneBC, .mellophone, .threeValveBBbTuba, .threeValveEbTuba, .fFrenchHorn:
                fingeringView = ThreeValveFingeringView(fingering: fingering, ratio: 1)
            case .euphoniumTCNC, .euphoniumTCC, .euphoniumBCNC, .euphoniumBCC:
                fingeringView = FourValveFingeringView(fingering: fingering, ratio: 1)
            case .tenorTrombone:
                fingeringView = PositionFingeringView(fingering: fingering, ratio: 1)
            case .fTriggerTenorTrombone:
                fingeringView = FTriggerPositionFingeringView(fingering: fingering, ratio: 1)
            case .fBbFrenchHorn:
                fingeringView = BbTriggerThreeValveFingeringView(fingering: fingering, ratio: 1)
            case .flute:
                fingeringView = FluteFingeringView(fingering: fingering, ratio: 1)
                yConstant = -5
            case .clarinet:
                fingeringView = ClarinetFingeringView(fingering: fingering, ratio: 0.75)
                yConstant = -15
            case .altoSaxophone, .tenorSaxophone:
                fingeringView = SaxophoneFingeringView(fingering: fingering, ratio: 0.70)
            case .baritoneSaxophone:
                fingeringView = BaritoneSaxophoneFingeringView(fingering: fingering, ratio: 0.70)
            }
            
            fingeringView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(fingeringView)
            
            NSLayoutConstraint.activate([
                fingeringView.centerXAnchor.constraint(equalTo: centerXAnchor),
                fingeringView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: yConstant)
            ])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

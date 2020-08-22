//
//  FingeringViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/19/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FingeringViewController: UIViewController {
    var fingering: Fingering!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(optionalLabel)
        
        NSLayoutConstraint.activate([
            optionalLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            optionalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let currentInstrumentType = ChartsController.shared.currentChart.instrument.type
        
        if fingering.keys == nil {
            optionalLabel.isHidden = false
        } else {
            let fingeringView: FingeringView
            
            switch currentInstrumentType {
            case .trumpet, .baritoneTC, .baritoneBC, .mellophone:
                fingeringView = ThreeValveFingeringView(fingering: fingering, ratio: 1)
            case .euphoniumTCNC, .euphoniumTCC, .euphoniumBCNC, .euphoniumBCC:
                fingeringView = FourValveFingeringView(fingering: fingering, ratio: 1)
            case .tenorTrombone:
                fingeringView = PositionFingeringView(fingering: fingering, ratio: 1)
            case .fTriggerTenorTrombone:
                fingeringView = FTriggerPositionFingeringView(fingering: fingering, ratio: 1)
            }
            
            fingeringView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(fingeringView)
            
            NSLayoutConstraint.activate([
                fingeringView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                fingeringView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentInstrumentType = ChartsController.shared.currentChart.instrument.type
        
        switch currentInstrumentType {
        case .trumpet:
            let finger1 = UIImageView(image: UIImage(named: (fingering.keys[0] ? "RoundFingeringFull1" : "RoundFingeringEmpty1"))!.withTintColor(UIColor(named: "Black")!))
            finger1.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(finger1)
            
            let finger2 = UIImageView(image: UIImage(named: (fingering.keys[1] ? "RoundFingeringFull2" : "RoundFingeringEmpty2"))!.withTintColor(UIColor(named: "Black")!))
            finger2.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(finger2)
            
            let finger3 = UIImageView(image: UIImage(named: (fingering.keys[2] ? "RoundFingeringFull3" : "RoundFingeringEmpty3"))!.withTintColor(UIColor(named: "Black")!))
            finger3.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(finger3)
            
            NSLayoutConstraint.activate([
                finger1.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -45),
                finger1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                finger2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                finger2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                finger3.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 45),
                finger3.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        case .euphoniumTCNC:
            let finger1 = UIImageView(image: UIImage(named: (fingering.keys[0] ? "RoundFingeringFull1" : "RoundFingeringEmpty1"))!.withTintColor(UIColor(named: "Black")!))
            finger1.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(finger1)
            
            let finger2 = UIImageView(image: UIImage(named: (fingering.keys[1] ? "RoundFingeringFull2" : "RoundFingeringEmpty2"))!.withTintColor(UIColor(named: "Black")!))
            finger2.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(finger2)
            
            let finger3 = UIImageView(image: UIImage(named: (fingering.keys[2] ? "RoundFingeringFull3" : "RoundFingeringEmpty3"))!.withTintColor(UIColor(named: "Black")!))
            finger3.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(finger3)
            
            let finger4 = UIImageView(image: UIImage(named: (fingering.keys[3] ? "RoundFingeringFull4" : "RoundFingeringEmpty4"))!.withTintColor(UIColor(named: "Black")!))
            finger4.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(finger4)
            
            NSLayoutConstraint.activate([
                finger1.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -67.5),
                finger1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                finger2.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -22.5),
                finger2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                finger3.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 22.5),
                finger3.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                
                finger4.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 67.5),
                finger4.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        }
    }
}

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
    
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 170, height: 40))
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let finger1 = UIImageView(image: UIImage(named: (fingering.keys[0] ? "TrumpetFingeringFull" : "TrumpetFingeringEmpty"))!.withTintColor(UIColor(named: "Black")!))
        finger1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(finger1)
        
        let finger2 = UIImageView(image: UIImage(named: (fingering.keys[1] ? "TrumpetFingeringFull" : "TrumpetFingeringEmpty"))!.withTintColor(UIColor(named: "Black")!))
        finger2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(finger2)
        
        let finger3 = UIImageView(image: UIImage(named: (fingering.keys[2] ? "TrumpetFingeringFull" : "TrumpetFingeringEmpty"))!.withTintColor(UIColor(named: "Black")!))
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
    }
}

//#if DEBUG
//import SwiftUI
//
//struct FingeringViewRepresentable: UIViewRepresentable {
//    func makeUIView(context: Context) -> UIView {
//        let vc = FingeringViewController()
//        vc.fingering = Fingering(keys: [false, true, false])
//        return vc.view
//    }
//
//    func updateUIView(_ view: UIView, context: Context) {
//        // Update your code here
//    }
//}
//
//@available(iOS 13.0, *)
//struct FingeringViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        FingeringViewRepresentable()
//    }
//}
//#endif

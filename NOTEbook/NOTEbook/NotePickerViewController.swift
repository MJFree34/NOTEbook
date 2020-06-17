//
//  ViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class NotePickerViewController: UIViewController {
    var charts = [FingeringChart]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addBackgroundGradient()
        
        if let chartsURL = Bundle.main.url(forResource: "Charts", withExtension: "json") {
            if let data = try? Data(contentsOf: chartsURL) {
                let decoder = JSONDecoder()
                
                do {
                    charts = try decoder.decode([FingeringChart].self, from: data)
                } catch {
                    print(error.localizedDescription, error)
                }
            }
        }
    }
}

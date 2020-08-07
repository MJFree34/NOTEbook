//
//  InstrumentsViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 8/7/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class InstrumentsViewController: UIViewController {
    let chartsController = ChartsController.shared
    
    var selectedIndex: IndexPath!
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.estimatedRowHeight = 100
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "LightestestAqua")
        
        title = "Instruments"
    }
}

extension InstrumentsViewController: UITableViewDelegate {}

extension InstrumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chartsController.instruments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let cellInstrumentType = chartsController.instruments[indexPath.row]
        
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.textLabel?.textColor = UIColor(named: "Black")
        cell.textLabel?.text = cellInstrumentType.rawValue
        cell.backgroundColor = .clear
        cell.tintColor = UIColor(named: "MediumRed")
        cell.selectionStyle = .none
        
        if cellInstrumentType == chartsController.currentChart.instrument.type {
            cell.accessoryType = .checkmark
            selectedIndex = indexPath
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath), cell.accessoryType != .checkmark {
            cell.accessoryType = .checkmark
            
            if let cell2 = tableView.cellForRow(at: selectedIndex) {
                cell2.accessoryType = .none
            }
            
            selectedIndex = indexPath
            
            chartsController.changeCurrentChartToChart(at: indexPath.row)
            
            UserDefaults.standard.setValue(indexPath.row, forKey: UserDefaults.Keys.currentInstrumentIndex)
        }
    }
}

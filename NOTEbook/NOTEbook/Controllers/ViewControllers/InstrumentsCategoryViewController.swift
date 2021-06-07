//
//  InstrumentsCategoryViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 9/5/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class InstrumentsCategoryViewController: InstrumentsViewController {
    private var category: ChartCategory
    private var categoryIndex: Int
    
    private lazy var tableView: ListTableView = {
        let tv = ListTableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    init(category: ChartCategory, index: Int) {
        self.category = category
        self.categoryIndex = index
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        title = category.name
    }
}

extension InstrumentsCategoryViewController: UITableViewDelegate {}

extension InstrumentsCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.fingeringCharts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let cellInstrumentType = category.fingeringCharts[indexPath.row].instrument.type
        
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.textLabel?.textColor = .notebookBlack
        cell.textLabel?.text = cellInstrumentType.rawValue
        cell.backgroundColor = .clear
        cell.accessoryType = .checkmark
        cell.selectionStyle = .none
        
        if cellInstrumentType == chartsController.currentChart.instrument.type {
            cell.tintColor = .notebookMediumRed
            selectedIndex = indexPath
        } else {
            cell.tintColor = .notebookMediumAqua
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath), cell.tintColor != .notebookMediumRed {
            if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
                UIImpactFeedbackGenerator.mediumTapticFeedbackOccurred()
            }
            
            cell.tintColor = .notebookMediumRed
            
            if let index = selectedIndex, let cell2 = tableView.cellForRow(at: index) {
                cell2.tintColor = .notebookMediumAqua
            }
            
            selectedIndex = indexPath
                
            chartsController.changeCurrentChart(to: category.name, chartIndex: indexPath.row)
            
            navigationController?.popToRootViewController(animated: true)
            NotificationCenter.default.post(name: .reloadInstrumentViews, object: nil)
        }
    }
}

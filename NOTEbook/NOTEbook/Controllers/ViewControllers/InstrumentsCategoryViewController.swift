//
//  InstrumentsCategoryViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 9/5/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class InstrumentsCategoryViewController: UIViewController {
    var chartsController = ChartsController.shared
    var category: ChartCategory
    var categoryIndex: Int
    
    private var selectedInstrumentIndex: IndexPath!
    
    private lazy var tableView: UITableView = {
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
        
        view.addBackground()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
        view.backgroundColor = UIColor(named: "LightestestAqua")
        
        title = category.name
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackground()
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
        cell.textLabel?.textColor = UIColor(named: "Black")
        cell.textLabel?.text = cellInstrumentType.rawValue
        cell.backgroundColor = .clear
        cell.accessoryType = .checkmark
        cell.selectionStyle = .none
        
        if cellInstrumentType == chartsController.currentChart.instrument.type {
            cell.tintColor = UIColor(named: "MediumRed")
            selectedInstrumentIndex = indexPath
        } else {
            cell.tintColor = UIColor(named: "MediumAqua")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath), cell.tintColor != UIColor(named: "MediumRed") {
            if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
                UIImpactFeedbackGenerator.mediumTapticFeedbackOccurred()
            }
            
            cell.tintColor = UIColor(named: "MediumRed")
            
            if let index = selectedInstrumentIndex, let cell2 = tableView.cellForRow(at: index) {
                cell2.tintColor = UIColor(named: "MediumAqua")
            }
            
            selectedInstrumentIndex = indexPath
                
            chartsController.changeCurrentChart(to: categoryIndex, instrumentIndex: indexPath.row)
            
            navigationController?.popToRootViewController(animated: true)
            NotificationCenter.default.post(name: .reloadInstrumentViews, object: nil)
        }
    }
}

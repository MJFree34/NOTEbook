//
//  InstrumentsViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 8/7/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class InstrumentsViewController: UIViewController {
    private let chartsController = ChartsController.shared
    
    private var selectedCategory: IndexPath!
    
    private lazy var woodwindStartIndex: Int = chartsController.chartCategories.count - 2
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
        view.backgroundColor = UIColor(named: "LightestestAqua")
        
        title = "Instruments"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

extension InstrumentsViewController: UITableViewDelegate {}

extension InstrumentsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return woodwindStartIndex
        case 1:
            return chartsController.chartCategories.count - woodwindStartIndex
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let cellChartCategoryName = chartsController.chartCategories[(indexPath.section == 0 ? indexPath.row : indexPath.row + woodwindStartIndex)].name
        
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.textLabel?.textColor = UIColor(named: "Black")
        cell.textLabel?.text = cellChartCategoryName
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if cellChartCategoryName == chartsController.currentChartCategory.name {
            cell.tintColor = UIColor(named: "MediumRed")
            selectedCategory = indexPath
        } else {
            cell.tintColor = UIColor(named: "MediumAqua")
        }
        
        if chartsController.chartCategories[(indexPath.section == 0 ? indexPath.row : indexPath.row + woodwindStartIndex)].fingeringCharts.count == 1 {
            cell.accessoryType = .checkmark
        } else {
            let chevronConfiguration = UIImage.SymbolConfiguration.init(font: UIFont.preferredFont(forTextStyle: .title3))
            let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: chevronConfiguration))
            cell.accessoryView = chevronImageView
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath), cell.tintColor != UIColor(named: "MediumRed") || cell.accessoryView != nil {
            if chartsController.chartCategories[(indexPath.section == 0 ? indexPath.row : indexPath.row + woodwindStartIndex)].fingeringCharts.count == 1 {
                cell.tintColor = UIColor(named: "MediumRed")
                
                if let cell2 = tableView.cellForRow(at: selectedCategory) {
                    cell2.tintColor = UIColor(named: "MediumAqua")
                }
                
                selectedCategory = indexPath
                
                chartsController.changeCurrentChart(to: (indexPath.section == 0 ? indexPath.row : indexPath.row + woodwindStartIndex), instrumentIndex: 0)
            } else {
                let vc = InstrumentsCategoryViewController(category: chartsController.chartCategories[(indexPath.section == 0 ? indexPath.row : indexPath.row + woodwindStartIndex)], index: (indexPath.section == 0 ? indexPath.row : indexPath.row + woodwindStartIndex))
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleCell = TitleCell()
        titleCell.titleLabel.textColor = UIColor(named: "DarkAqua")
        titleCell.titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        titleCell.cellDivider.isHidden = false
        
        switch section {
        case 0:
            titleCell.titleLabel.text = "Brass"
        case 1:
            titleCell.titleLabel.text = "Woodwinds"
        default:
            break
        }
        
        return titleCell
    }
}

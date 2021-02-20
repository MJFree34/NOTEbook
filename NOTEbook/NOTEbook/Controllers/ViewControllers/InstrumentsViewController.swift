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
    
    private lazy var woodwindsChartCategories: [ChartCategory] = {
        var categories = [ChartCategory]()
        
        for category in chartsController.purchasedChartCategories {
            if category.name == "Flute" || category.name == "Clarinet" || category.name == "Saxophone" {
                categories.append(category)
            }
        }
        
        return categories
    }()
    
    private lazy var brassChartCategories: [ChartCategory] = {
        var categories = [ChartCategory]()
        
        for category in chartsController.purchasedChartCategories {
            if category.name == "Trumpet" || category.name == "Mellophone" || category.name == "French Horn" || category.name == "Trombone" || category.name == "Baritone" || category.name == "Euphonium" || category.name == "Tuba" {
                categories.append(category)
            }
        }
        
        return categories
    }()
    
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
        
        view.addBackground()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
        title = "Instruments"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackground()
    }
}

extension InstrumentsViewController: UITableViewDelegate {}

extension InstrumentsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if woodwindsChartCategories.count == 0 || brassChartCategories.count == 0 {
            return 1
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if woodwindsChartCategories.count != 0 {
                return woodwindsChartCategories.count
            } else {
                return brassChartCategories.count
            }
        case 1:
            return brassChartCategories.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cellChartCategory: ChartCategory
        
        if indexPath.section == 0 && woodwindsChartCategories.count != 0 {
            cellChartCategory = woodwindsChartCategories[indexPath.row]
        } else {
            cellChartCategory = brassChartCategories[indexPath.row]
        }
        
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.textLabel?.textColor = UIColor(named: "Black")
        cell.textLabel?.text = cellChartCategory.name
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if cellChartCategory.name == chartsController.currentChartCategory.name {
            cell.tintColor = UIColor(named: "MediumRed")
            selectedCategory = indexPath
        } else {
            cell.tintColor = UIColor(named: "MediumAqua")
        }
        
        if cellChartCategory.fingeringCharts.count == 1 {
            cell.accessoryType = .checkmark
            cell.accessoryView = nil
        } else {
            let chevronConfiguration = UIImage.SymbolConfiguration.init(font: UIFont.preferredFont(forTextStyle: .title3))
            let chevronImageView = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: chevronConfiguration))
            cell.accessoryView = chevronImageView
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath), cell.tintColor != UIColor(named: "MediumRed") || cell.accessoryView != nil {
            let cellChartCategory: ChartCategory
            
            if indexPath.section == 0 && woodwindsChartCategories.count != 0 {
                cellChartCategory = woodwindsChartCategories[indexPath.row]
            } else {
                cellChartCategory = brassChartCategories[indexPath.row]
            }
            
            let categoryIndex = indexPath.section == 0 ? indexPath.row : indexPath.row + woodwindsChartCategories.count
            
            if cellChartCategory.fingeringCharts.count == 1 {
                if UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled) {
                    UIImpactFeedbackGenerator.mediumTapticFeedbackOccurred()
                }
                
                cell.tintColor = UIColor(named: "MediumRed")
                
                if let cell2 = tableView.cellForRow(at: selectedCategory) {
                    cell2.tintColor = UIColor(named: "MediumAqua")
                }
                
                selectedCategory = indexPath
                
                chartsController.changeCurrentChart(to: chartsController.purchasedChartCategories[categoryIndex].name, chartIndex: 0)
                
                navigationController?.popToRootViewController(animated: true)
                NotificationCenter.default.post(name: .reloadInstrumentViews, object: nil)
            } else {
                let vc = InstrumentsCategoryViewController(category: cellChartCategory, index: categoryIndex)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleCell = TitleCell()
        titleCell.titleLabel.textColor = UIColor(named: "DarkAqua")
        titleCell.titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        titleCell.cellDivider.isHidden = false
        
        if section == 0 {
            if woodwindsChartCategories.count != 0 {
                titleCell.titleLabel.text = "Woodwinds"
            } else {
                titleCell.titleLabel.text = "Brass"
            }
        } else if section == 1 {
            titleCell.titleLabel.text = "Brass"
        }
        
        return titleCell
    }
}

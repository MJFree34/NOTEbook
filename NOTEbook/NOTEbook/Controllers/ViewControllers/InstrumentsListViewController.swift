//
//  InstrumentsListViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 8/7/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class InstrumentsListViewController: InstrumentsViewController {
    private lazy var woodwindsChartCategories: [ChartCategory] = {
        return reloadWoodwindChartCategories()
    }()
    
    private lazy var brassChartCategories: [ChartCategory] = {
        return reloadBrassChartCategories()
    }()
    
    private lazy var tableView: ListTableView = {
        let tv = ListTableView()
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        title = "Instruments"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        woodwindsChartCategories = reloadWoodwindChartCategories()
        brassChartCategories = reloadBrassChartCategories()
        
        tableView.reloadData()
    }
    
    private func reloadWoodwindChartCategories() -> [ChartCategory] {
        var categories = [ChartCategory]()
        
        for category in chartsController.purchasedChartCategories {
            if category.section == .woodwinds {
                categories.append(category)
            }
        }
        
        return categories
    }
    
    private func reloadBrassChartCategories() -> [ChartCategory] {
        var categories = [ChartCategory]()
        
        for category in chartsController.purchasedChartCategories {
            if category.section == .brass {
                categories.append(category)
            }
        }
        
        return categories
    }
}

extension InstrumentsListViewController: UITableViewDelegate {}

extension InstrumentsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if woodwindsChartCategories.isEmpty || brassChartCategories.isEmpty {
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
        cell.textLabel?.textColor = .notebookBlack
        cell.textLabel?.text = cellChartCategory.name
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if cellChartCategory.name == chartsController.currentChartCategory.name {
            cell.tintColor = .notebookMediumRed
            selectedIndex = indexPath
        } else {
            cell.tintColor = .notebookMediumAqua
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
        if let cell = tableView.cellForRow(at: indexPath), cell.tintColor != .notebookMediumRed || cell.accessoryView != nil {
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
                
                cell.tintColor = .notebookMediumRed
                
                if let cell2 = tableView.cellForRow(at: selectedIndex) {
                    cell2.tintColor = .notebookMediumAqua
                }
                
                selectedIndex = indexPath
                
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
        titleCell.titleLabel.textColor = .notebookDarkAqua
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

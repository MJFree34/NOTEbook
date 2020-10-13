//
//  FingeringLimitViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 10/13/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FingeringLimitViewController: UITableViewController {
    let fingeringLimitOptions = [1, 2, 3, 4, 5, 6, 7]
    
    var selectedIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Fingering Limit"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.backgroundColor = UIColor(named: "LightestestAqua")
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fingeringLimitOptions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.backgroundColor = UIColor(named: "LightestAqua")
        cell.selectionStyle = .none
        cell.tintColor = UIColor(named: "MediumRed")
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(fingeringLimitOptions[indexPath.row])"
        cell.textLabel?.textColor = UIColor(named: "Black")
        
        if fingeringLimitOptions[indexPath.row] == UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit) {
            cell.accessoryType = .checkmark
            selectedIndex = indexPath
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        guard let cell2 = tableView.cellForRow(at: selectedIndex) else { return }
        
        cell2.accessoryType = .none
        cell.accessoryType = .checkmark
        
        selectedIndex = indexPath
        UserDefaults.standard.set(fingeringLimitOptions[indexPath.row], forKey: UserDefaults.Keys.fingeringsLimit)
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Number of fingerings shown for each note"
    }
}

//
//  FingeringLimitViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 10/13/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import UIKit

class FingeringLimitViewController: UIViewController {
    let fingeringLimitOptions = [1, 2, 3, 4, 5, 6, 7]
    
    private var selectedIndex: IndexPath!
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.backgroundColor = .clear
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.estimatedRowHeight = 60
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Fingering Limit"
        
        view.addBackground()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addBackground()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackground()
    }
}

extension FingeringLimitViewController: UITableViewDelegate {}

extension FingeringLimitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fingeringLimitOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.backgroundColor = .notebookLightestAqua
        cell.selectionStyle = .none
        cell.tintColor = .notebookMediumRed
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(fingeringLimitOptions[indexPath.row])"
        cell.textLabel?.textColor = .notebookBlack
        
        if fingeringLimitOptions[indexPath.row] == UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit) {
            cell.accessoryType = .checkmark
            selectedIndex = indexPath
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        guard let cell2 = tableView.cellForRow(at: selectedIndex) else { return }
        
        cell2.accessoryType = .none
        cell.accessoryType = .checkmark
        
        selectedIndex = indexPath
        UserDefaults.standard.set(fingeringLimitOptions[indexPath.row], forKey: UserDefaults.Keys.fingeringsLimit)
        NotificationCenter.default.post(name: .reloadInstrumentViews, object: nil)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Number of fingerings shown for each note"
    }
}

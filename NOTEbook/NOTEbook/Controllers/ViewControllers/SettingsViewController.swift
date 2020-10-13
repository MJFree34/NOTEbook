//
//  SettingsViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 7/2/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

enum Section: String {
    case customize, actions, about
}

import UIKit
import SafariServices

class SettingsViewController: UITableViewController {
    private let sections = [Section.customize, Section.actions, Section.about]
    private let customize = ["Haptics Enabled"]
    private let actions = ["Show Tutorial", "Send Feedback", "Rate in App Store"]
    private let about = [["Current Version", "1.0.1 (3)"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.backgroundColor = UIColor(named: "LightestestAqua")
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return customize.count
        case 1:
            return actions.count
        case 2:
            return about.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.backgroundColor = UIColor(named: "LightestAqua")
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor(named: "MediumAqua")
        
        cell.textLabel?.numberOfLines = 0
        
        switch sections[indexPath.section] {
        case .customize:
            cell.textLabel?.text = customize[indexPath.row]
            cell.textLabel?.textColor = UIColor(named: "Black")
            
            let switchView = UISwitch()
            switchView.isOn = UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled)
            switchView.onTintColor = UIColor(named: "MediumAqua")
            switchView.addTarget(self, action: #selector(toggleHaptics), for: .valueChanged)
            
            cell.accessoryView = switchView
        case .actions:
            cell.textLabel?.text = actions[indexPath.row]
            cell.textLabel?.textColor = UIColor(named: "DarkAqua")
            cell.textLabel?.highlightedTextColor = UIColor(named: "LightAqua")
        case .about:
            cell.textLabel?.text = about[indexPath.row][0]
            cell.selectionStyle = .none

            let accessoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
            accessoryLabel.font = UIFont.preferredFont(forTextStyle: .body)
            accessoryLabel.text = about[indexPath.row][1]
            accessoryLabel.textColor = .secondaryLabel
            accessoryLabel.textAlignment = .right

            cell.accessoryView = accessoryLabel
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .customize:
            break
        case .actions:
            switch indexPath.row {
            case 0:
                present(TutorialViewController(), animated: true, completion: { [weak self] in
                    self?.tableView.deselectRow(at: IndexPath(row: 0, section: 1), animated: true)
                })
            case 1:
                openFeedback()
            case 2:
                openAppStore()
            default:
                break
            }
        case .about:
            break
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].rawValue.capitalized
    }
    
    func openFeedback() {
        if let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSdsy1jt7xngJS4BYxV_DyyogpLKVY6346X2RcogstWbtqo6Rw/viewform") {
            let vc = SFSafariViewController(url: url)
            
            present(vc, animated: true)
        }
    }
    
    func openAppStore() {
        let appID = 1523098465
        if let url = URL(string: "https://itunes.apple.com/app/id\(appID)?action=write-review") {
            UIApplication.shared.open(url, options: [:]) { [weak self] _ in
                self?.tableView.deselectRow(at: IndexPath(row: 2, section: 1), animated: true)
            }
        }
    }
    
    @objc func toggleHaptics() {
        let pastSetting = UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled)
        UserDefaults.standard.setValue(!pastSetting, forKey: UserDefaults.Keys.hapticsEnabled)
    }
}

#if DEBUG
import SwiftUI

struct SettingsViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return SettingsViewController(style: .insetGrouped)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update code
    }
}

struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsViewControllerRepresentable()
                .previewDisplayName("iPhone 11 Pro Max")
                .previewDevice("iPhone 11 Pro Max")
            SettingsViewControllerRepresentable()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .large)
                .previewDisplayName("iPhone SE (2nd generation)")
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
#endif

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

import MessageUI
import SafariServices
import UIKit

class SettingsViewController: UITableViewController {
    private let sections = [Section.customize, Section.actions, Section.about]
    private var customize = ["Fingerings Limit", "Haptics Enabled", "Gradient Enabled"]
    private var actions = ["Show Tutorial", "Rate in App Store", "Send Feedback", "Email Developer"]
    private var about = [["Current Version", "1.1.0 (6)"]]
    
    private lazy var fingeringsLimitAccessoryLabel: UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        lab.font = UIFont.preferredFont(forTextStyle: .body)
        lab.text = "\(UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit))"
        lab.textColor = .secondaryLabel
        lab.textAlignment = .right
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        return lab
    }()
    
    override func viewDidLoad() {
        editSettingsForDevice()
        
        super.viewDidLoad()
        
        title = "Settings"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateBackground()
        
        fingeringsLimitAccessoryLabel.text = "\(UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit))"
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
            
            switch indexPath.row {
            case 0:
                cell.accessoryType = .disclosureIndicator
                
                cell.addSubview(fingeringsLimitAccessoryLabel)
                
                NSLayoutConstraint.activate([
                    fingeringsLimitAccessoryLabel.centerYAnchor.constraint(equalTo: cell.textLabel!.centerYAnchor),
                    fingeringsLimitAccessoryLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -40)
                ])
            case 1, 2:
                cell.selectionStyle = .none
                
                let switchView = UISwitch()
                switchView.onTintColor = UIColor(named: "MediumAqua")
                if indexPath.row == 1 {
                    switchView.isOn = UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled)
                    switchView.addTarget(self, action: #selector(toggleHaptics), for: .valueChanged)
                } else if indexPath.row == 2 {
                    switchView.isOn = UserDefaults.standard.bool(forKey: UserDefaults.Keys.gradientEnabled)
                    switchView.addTarget(self, action: #selector(toggleGradient), for: .valueChanged)
                }
                
                cell.accessoryView = switchView
            default:
                break
            }
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
            switch indexPath.row {
            case 0:
                let vc = FingeringLimitViewController(style: .insetGrouped)
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                break
            default:
                break
            }
        case .actions:
            switch indexPath.row {
            case 0:
                UserDefaults.standard.set(false, forKey: UserDefaults.Keys.tutorialHasShown)
                navigationController?.popToRootViewController(animated: true)
            case 1:
                openAppStore()
            case 2:
                openFeedback()
            case 3:
                // Only occurs when not AppStore version
                openEmail()
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
    
    private func editSettingsForDevice() {
        if isOldDevice() {
            customize.remove(at: 1)
        } else if Configuration.appConfiguration == .appStore {
            actions.remove(at: 3)
        }
    }
    
    private func isOldDevice() -> Bool {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        // iPhone 6s or 6s Plus
        return identifier == "iPhone8,1" || identifier == "iPhone8,2"
    }
    
    private func openFeedback() {
        if let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSdsy1jt7xngJS4BYxV_DyyogpLKVY6346X2RcogstWbtqo6Rw/viewform") {
            let vc = SFSafariViewController(url: url)
            
            present(vc, animated: true)
        }
    }
    
    private func openAppStore() {
        let appID = 1523098465
        if let url = URL(string: "https://itunes.apple.com/app/id\(appID)?action=write-review") {
            UIApplication.shared.open(url, options: [:]) { [weak self] _ in
                self?.tableView.deselectRow(at: IndexPath(row: 2, section: 1), animated: true)
            }
        }
    }
    
    @objc private func toggleHaptics() {
        let pastSetting = UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled)
        UserDefaults.standard.setValue(!pastSetting, forKey: UserDefaults.Keys.hapticsEnabled)
    }
    
    @objc private func toggleGradient() {
        let pastSetting = UserDefaults.standard.bool(forKey: UserDefaults.Keys.gradientEnabled)
        UserDefaults.standard.setValue(!pastSetting, forKey: UserDefaults.Keys.gradientEnabled)
        
        updateBackground()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        updateBackground()
    }
    
    private func updateBackground() {
        tableView.backgroundView = nil
        tableView.backgroundColor = nil
        
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.gradientEnabled) {
            let backgroundView = UIView(frame: tableView.frame)
            backgroundView.addBackgroundGradient()
            tableView.backgroundView = backgroundView
        } else {
            tableView.backgroundColor = UIColor(named: "LightestestAqua")
        }
    }
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    private func openEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients(["MusiciansNOTEbook.Feedback@gmail.com"])
            mailVC.setSubject("NOTEbook Feedback and Suggestions")
            
            present(mailVC, animated: true)
        } else {
            let ac = UIAlertController(title: "Error sending email", message: "Please make sure your device has mail setup.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default))
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        tableView.deselectRow(at: IndexPath(row: 3, section: 1), animated: true)
    }
}

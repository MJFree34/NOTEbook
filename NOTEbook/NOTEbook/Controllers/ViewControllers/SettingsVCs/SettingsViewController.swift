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
    private let customize = ["Haptics Enabled", "Fingerings Limit"]
    private let actions = ["Show Tutorial", "Rate in App Store", "Send Feedback", "Email Developer"]
    private let about = [["Current Version", "1.1.0 (3)"]]

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
            if Configuration.appConfiguration == .AppStore {
                return actions.count - 1
            }
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
                cell.selectionStyle = .none
                
                let switchView = UISwitch()
                switchView.isOn = UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled)
                switchView.onTintColor = UIColor(named: "MediumAqua")
                switchView.addTarget(self, action: #selector(toggleHaptics), for: .valueChanged)
                
                cell.accessoryView = switchView
            case 1:
                cell.accessoryType = .disclosureIndicator
                
                cell.addSubview(fingeringsLimitAccessoryLabel)
                
                NSLayoutConstraint.activate([
                    fingeringsLimitAccessoryLabel.centerYAnchor.constraint(equalTo: cell.textLabel!.centerYAnchor),
                    fingeringsLimitAccessoryLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -40)
                ])
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
                break
            case 1:
                let vc = FingeringLimitViewController(style: .insetGrouped)
                navigationController?.pushViewController(vc, animated: true)
            default:
                break
            }
        case .actions:
            switch indexPath.row {
            case 0:
                let vc = TutorialViewController()
                present(vc, animated: true, completion: { [weak self] in
                    self?.tableView.deselectRow(at: IndexPath(row: 0, section: 1), animated: true)
                })
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

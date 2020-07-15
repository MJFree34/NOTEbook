//
//  SettingsViewController.swift
//  NOTEbook
//
//  Created by Matt Free on 7/2/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

enum Section: String {
    case actions, about
}

import UIKit
import MessageUI

class SettingsViewController: UITableViewController {
    let sections = [Section.actions, Section.about]
    let actions = ["Show Tutorial", "Suggestions or Feedback?"]
    let about = [["Current Version", "1.0 (3)"]]

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
            return actions.count
        case 1:
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
        case .actions:
            switch indexPath.row {
            case 0:
                navigationController?.present(TutorialViewController(), animated: true, completion: { [weak self] in
                    self?.tableView.deselectRow(at: IndexPath(row: 0, section: 0), animated: true)
                })
            case 1:
                sendEmail()
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
}

extension SettingsViewController: MFMailComposeViewControllerDelegate {
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients(["MusiciansNOTEbook.Feedback@gmail.com"])
            mailVC.setSubject("NOTEbook Feedback and Suggestions")
            
            present(mailVC, animated: true)
        } else {
            let ac = UIAlertController(title: "Error sending email", message: "Please make sure your device has mail setup.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Okay", style: .default))
            
            present(ac, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        tableView.deselectRow(at: IndexPath(row: 1, section: 0), animated: true)
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

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

class SettingsViewController: UITableViewController {
    let sections = [Section.actions, Section.about]
    let actions = ["Show Tutorial", "Suggestions or Feedback?"]
    let about = [["Current Version", "1.0"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.interactivePopGestureRecognizer?.delegate = nil

        title = "Settings"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.backgroundColor = UIColor(named: "LightestestAqua")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { fatalError() }

        cell.backgroundColor = UIColor(named: "LightestAqua")
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor(named: "MediumAqua")

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
                // TODO: Show tutorial
                print("Show tutorial")
            case 1:
                // TODO: Show email
                print("Show email")
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

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

#if DEBUG
import SwiftUI

struct SettingsViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return SettingsViewController(style: .insetGrouped).view
    }

    func updateUIView(_ view: UIView, context: Context) {
        // Update your code here
    }
}

struct SettingsViewController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsViewRepresentable()
                .previewDisplayName("iPhone 11 Pro Max")
                .previewDevice("iPhone 11 Pro Max")
            SettingsViewRepresentable()
                .preferredColorScheme(.dark)
                .previewDisplayName("iPhone SE (2nd generation)")
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
#endif

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
import Purchases
import SafariServices
import UIKit

class SettingsViewController: UIViewController {
    private let sections = [Section.customize, Section.actions, Section.about]
    private var customize = ["Fingerings Limit",
                             "Haptics Enabled",
                             "Gradient Enabled"]
    private var actions = ["Shop Instruments",
                           "Restore Purchases",
                           "Show Tutorial",
                           "Rate in App Store",
                           "Send Feedback",
                           "Email Developer",
                           "End Free Trial"]
    private var about = [["\(Bundle.main.appName) Version", "\(Bundle.main.appVersion) (\(Bundle.main.buildNumber))"],
                         ["Configuration", "\(Configuration.appConfiguration.rawValue)"],
                         ["UserID", ""],
                         ["Free Trial Left", ""]]
    
    private var freeTrialTimer: Timer?
    
    private lazy var fingeringsLimitAccessoryLabel: UILabel = {
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        lab.font = UIFont.preferredFont(forTextStyle: .body)
        lab.text = "\(UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit))"
        lab.textColor = .secondaryLabel
        lab.textAlignment = .right
        lab.translatesAutoresizingMaskIntoConstraints = false
        
        return lab
    }()
    
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.backgroundColor = .clear
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.estimatedRowHeight = 60
        tv.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    override func viewDidLoad() {
        editSettingsForDevice()
        
        super.viewDidLoad()
        
        title = "Settings"
        
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
        
        tableView.deselectRow(at: IndexPath(row: actions.firstIndex(of: "Shop Instruments") ?? 0, section: 1), animated: true)
        tableView.deselectRow(at: IndexPath(row: customize.firstIndex(of: "Fingerings Limit") ?? 0, section: 0), animated: true)
        
        fingeringsLimitAccessoryLabel.text = "\(UserDefaults.standard.integer(forKey: UserDefaults.Keys.fingeringsLimit))"
        
        Purchases.shared.purchaserInfo { purchaserInfo, error in
            let userID = purchaserInfo?.originalAppUserId ?? "None"
            self.refreshUserID(userID)
        }
        
        freeTrialTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(decrementFreeTrialLeft), userInfo: nil, repeats: true)
        refreshFreeTrialLeft()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        freeTrialTimer?.invalidate()
    }
    
    private func editSettingsForDevice() {
        let iapFlowHasShown = UserDefaults.standard.bool(forKey: UserDefaults.Keys.iapFlowHasShown)
        let freeTrialOver = UserDefaults.standard.bool(forKey: UserDefaults.Keys.freeTrialOver)
        
        if isOldDevice() {
            customize.removeAll { $0 == "Haptics Enabled" }
        }
        
        if Configuration.appConfiguration == .appStore {
            actions.removeAll { $0 == "Email Developer" }
            about.removeAll { $0[0] == "UserID" }
        }
        
        if Configuration.appConfiguration != .testFlight && freeTrialOver {
            about.removeAll { $0[0] == "Free Trial Left" }
        }
        
        if freeTrialOver || Configuration.appConfiguration == .testFlight {
            actions.removeAll { $0 == "End Free Trial" }
        }
        
        if !freeTrialOver && !iapFlowHasShown && Configuration.appConfiguration != .testFlight {
            actions.removeAll { $0 == "Shop Instruments" }
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
    
    private func refreshFreeTrialLeft() {
        var freeTrialData = FreeTrialData()
        let freeTrialLeftIndex = about.firstIndex { $0[0] == "Free Trial Left" } ?? 0
        about[freeTrialLeftIndex][1] = "\(freeTrialData.daysRemaining)D:\(freeTrialData.hoursRemaining)H:\(freeTrialData.minutesRemaining)M:\(freeTrialData.secondsRemaining)S"
        tableView.reloadRows(at: [IndexPath(row: freeTrialLeftIndex, section: 2)], with: .none)
    }
    
    private func refreshUserID(_ userID: String) {
        var userID = userID
        let userIDIndex = about.firstIndex { $0[0] == "UserID" } ?? 0
        userID.removeFirst(15)
        about[userIDIndex][1] = userID
    }
    
    private func openIAPScreen() {
        ChartsController.shared.updatePurchasableInstrumentGroups()
        let vc = PurchaseInstrumentsViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func restorePurchases() {
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.hidesWhenStopped = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: loadingIndicator)
        
        loadingIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        
        Purchases.shared.restoreTransactions { purchaserInfo, error in
            loadingIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
            
            self.tableView.deselectRow(at: IndexPath(row: self.actions.firstIndex(of: "Restore Purchases") ?? 0, section: 1), animated: true)
            
            if let error = error {
                self.showAlert(title: "Error restoring purchases: \(error.localizedDescription)", message: nil)
            } else {
                self.showAlert(title: "Purchases restored!", message: nil) { _ in
                    let firstSeenDate = purchaserInfo?.firstSeen ?? Date()
                    UserDefaults.standard.set(firstSeenDate.timeIntervalSince1970, forKey: UserDefaults.Keys.firstLaunchDate)
                    self.refreshFreeTrialLeft()
                    
                    let userID = purchaserInfo?.originalAppUserId ?? "None"
                    self.refreshUserID(userID)
                    
                    let twoWeeks = 60.0
                    
                    if purchaserInfo?.entitlements["all"]?.isActive == true ||
                        purchaserInfo?.entitlements["woodwinds"]?.isActive == true ||
                        purchaserInfo?.entitlements["brass"]?.isActive == true ||
                        purchaserInfo?.entitlements["flute"]?.isActive == true ||
                        purchaserInfo?.entitlements["clarinet"]?.isActive == true ||
                        purchaserInfo?.entitlements["saxophone"]?.isActive == true ||
                        purchaserInfo?.entitlements["trumpet"]?.isActive == true ||
                        purchaserInfo?.entitlements["french_horn"]?.isActive == true ||
                        purchaserInfo?.entitlements["trombone"]?.isActive == true ||
                        purchaserInfo?.entitlements["euphonium"]?.isActive == true ||
                        purchaserInfo?.entitlements["tuba"]?.isActive == true ||
                        firstSeenDate.timeIntervalSince1970 < Date().timeIntervalSince1970 - twoWeeks {
                        if purchaserInfo?.entitlements["all"]?.isActive == true {
                            UserDefaults.standard.set(true, forKey: UserDefaults.Keys.iapFlowHasShown)
                            UserDefaults.standard.set(0, forKey: UserDefaults.Keys.chosenFreeInstrumentGroupIndex)
                        }
                        
                        self.endFreeTrial()
                    }
                }
            }
        }
    }
    
    private func openTutorial() {
        UserDefaults.standard.set(false, forKey: UserDefaults.Keys.tutorialHasShown)
        navigationController?.popToRootViewController(animated: true)
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
                self?.tableView.deselectRow(at: IndexPath(row: self?.actions.firstIndex(of: "Rate in App Store") ?? 0, section: 1), animated: true)
            }
        }
    }
    
    private func endFreeTrial() {
        let alert = UIAlertController(title: "End free trial", message: "Are you sure you want to end the free trial? This is unrevocable.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.tableView.deselectRow(at: IndexPath(row: self.actions.firstIndex(of: "End Free Trial") ?? 0, section: 1), animated: true)
        })
        alert.addAction(UIAlertAction(title: "End", style: .destructive) { _ in
            UserDefaults.standard.set(true, forKey: UserDefaults.Keys.freeTrialOver)
            ChartsController.shared.updatePurchasableInstrumentGroups()
            self.tableView.deselectRow(at: IndexPath(row: self.actions.firstIndex(of: "End Free Trial") ?? 0, section: 1), animated: true)
            self.navigationController?.popToRootViewController(animated: true)
        })
        self.present(alert, animated: true)
    }
    
    @objc private func decrementFreeTrialLeft() {
        refreshFreeTrialLeft()
    }
    
    @objc private func toggleHaptics() {
        let pastSetting = UserDefaults.standard.bool(forKey: UserDefaults.Keys.hapticsEnabled)
        UserDefaults.standard.setValue(!pastSetting, forKey: UserDefaults.Keys.hapticsEnabled)
    }
    
    @objc private func toggleGradient() {
        let pastSetting = UserDefaults.standard.bool(forKey: UserDefaults.Keys.gradientEnabled)
        UserDefaults.standard.setValue(!pastSetting, forKey: UserDefaults.Keys.gradientEnabled)
        
        view.addBackground()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) else { return }
        
        view.addBackground()
    }
}

extension SettingsViewController: UITableViewDelegate {}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let containsFingeringsLimitRow = tableView.indexPathsForVisibleRows?.contains(IndexPath(row: customize.firstIndex(of: "Fingerings Limit") ?? 0, section: 0)) {
            if !containsFingeringsLimitRow {
                fingeringsLimitAccessoryLabel.removeFromSuperview()
            }
        }
        
        cell.backgroundColor = UIColor(named: "LightestAqua")
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor(named: "MediumAqua")
        cell.accessoryView = nil
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        
        switch sections[indexPath.section] {
        case .customize:
            cell.textLabel?.text = customize[indexPath.row]
            cell.textLabel?.textColor = UIColor(named: "Black")
            
            switch indexPath.row {
            case 0:
                cell.selectionStyle = .default
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
            
            cell.selectionStyle = .default
            
            if actions[indexPath.row] == "Shop Instruments" {
                let configuration = UIImage.SymbolConfiguration(font: UIFont.preferredFont(forTextStyle: .title3))
                let shopImage = UIImage(systemName: "dollarsign.circle",  withConfiguration: configuration)
                let shopImageView = UIImageView(image: shopImage)
                shopImageView.tintColor = UIColor(named: "MediumAqua")
                cell.accessoryView = shopImageView
            }
        case .about:
            cell.textLabel?.text = about[indexPath.row][0]
            cell.selectionStyle = .none
            
            let accessoryLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
            accessoryLabel.font = UIFont.preferredFont(forTextStyle: .body)
            accessoryLabel.text = about[indexPath.row][1]
            accessoryLabel.textColor = .secondaryLabel
            accessoryLabel.textAlignment = .right
            
            cell.accessoryView = accessoryLabel
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section] {
        case .customize:
            switch indexPath.row {
            case 0:
                let vc = FingeringLimitViewController()
                navigationController?.pushViewController(vc, animated: true)
            case 1:
                break
            case 2:
                break
            default:
                break
            }
        case .actions:
            switch actions[indexPath.row] {
            case "Shop Instruments":
                openIAPScreen()
            case "Restore Purchases":
                restorePurchases()
            case "Show Tutorial":
                openTutorial()
            case "Rate in App Store":
                openAppStore()
            case "Send Feedback":
                openFeedback()
            case "Email Developer":
                openEmail()
            case "End Free Trial":
                endFreeTrial()
            default:
                break
            }
        case .about:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].rawValue.capitalized
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
        tableView.deselectRow(at: IndexPath(row: actions.firstIndex(of: "Email Developer") ?? 0, section: 1), animated: true)
    }
}

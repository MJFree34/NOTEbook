//
//  AppDelegate.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Purchases
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Purchases.debugLogsEnabled = true
        Purchases.configure(withAPIKey: "HFqficbsMOZqTtlTYRadSMfyFkwVlSpn")
        
        UserDefaults.standard.register(defaults: [
            UserDefaults.Keys.tutorialHasShown: false,
            UserDefaults.Keys.currentChartCategoryName: "Trumpet",
            UserDefaults.Keys.currentChartIndex: 0,
            UserDefaults.Keys.hapticsEnabled: true,
            UserDefaults.Keys.gradientEnabled: true,
            UserDefaults.Keys.fingeringsLimit: 7,
            UserDefaults.Keys.chosenFreeInstrumentGroupIndex: 0,
            UserDefaults.Keys.iapFlowHasShown: false,
            UserDefaults.Keys.instrumentPrice: 1.99,
            UserDefaults.Keys.firstLaunchDate: 0.0,
            UserDefaults.Keys.firstLaunch: true,
            UserDefaults.Keys.freeTrialOver: false
        ])
        
        let now = Date()
        
        if UserDefaults.standard.bool(forKey: UserDefaults.Keys.firstLaunch) {
            Purchases.shared.purchaserInfo { purchaserInfo, error in
                let firstSeenDate = purchaserInfo?.firstSeen ?? now
                UserDefaults.standard.set(firstSeenDate.timeIntervalSince1970, forKey: UserDefaults.Keys.firstLaunchDate)
            }
            UserDefaults.standard.set(false, forKey: UserDefaults.Keys.firstLaunch)
        } else {
            let firstSeenDate = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: UserDefaults.Keys.firstLaunchDate))
            let twoWeeks = 60.0 * 60.0 * 24.0 * 14.0

            if firstSeenDate.timeIntervalSince1970 < now.timeIntervalSince1970 - twoWeeks && Configuration.appConfiguration != .testFlight {
                UserDefaults.standard.set(true, forKey: UserDefaults.Keys.freeTrialOver)
            } else if Configuration.appConfiguration != .debug {
                UserDefaults.standard.set(false, forKey: UserDefaults.Keys.freeTrialOver)
            }
        }
        
        StoreKitHelper.incrementNumberOfTimesLaunched()
        
        return true
    }
}

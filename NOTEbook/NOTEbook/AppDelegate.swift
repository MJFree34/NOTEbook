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
        
        StoreKitHelper.incrementNumberOfTimesLaunched()
        
        UserDefaults.standard.register(defaults: [
            UserDefaults.Keys.tutorialHasShown: false,
            UserDefaults.Keys.currentInstrumentIndex: 0,
            UserDefaults.Keys.currentChartCategoryIndex: 3,
            UserDefaults.Keys.hapticsEnabled: true,
            UserDefaults.Keys.gradientEnabled: true,
            UserDefaults.Keys.fingeringsLimit: 7
        ])
        
        return true
    }
}


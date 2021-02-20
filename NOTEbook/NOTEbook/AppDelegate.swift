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
        
        print(Purchases.shared.appUserID)
        
        StoreKitHelper.incrementNumberOfTimesLaunched()
        
        UserDefaults.standard.register(defaults: [
            UserDefaults.Keys.tutorialHasShown: false,
            UserDefaults.Keys.currentChartCategoryName: "Trumpet",
            UserDefaults.Keys.currentChartIndex: 0,
            UserDefaults.Keys.hapticsEnabled: true,
            UserDefaults.Keys.gradientEnabled: true,
            UserDefaults.Keys.fingeringsLimit: 7,
            UserDefaults.Keys.chosenFreeInstrumentGroupIndex: 0,
            UserDefaults.Keys.iapFlowHasShown: false,
            UserDefaults.Keys.instrumentPrice: 1.99
        ])
        
        return true
    }
}


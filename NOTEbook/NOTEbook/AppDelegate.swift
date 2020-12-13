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
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


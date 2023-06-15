//
//  StoreKitHelper.swift
//  NOTEbook
//
//  Created by Matt Free on 10/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import StoreKit

struct StoreKitHelper {
    static func displayStoreKit() {
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String else { return }
        
        let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: UserDefaults.Keys.lastVersion)
        let numberOfTimesLaunched = UserDefaults.standard.integer(forKey: UserDefaults.Keys.numberOfTimesLaunched)
        
        if numberOfTimesLaunched >= 7 && currentVersion != lastVersionPromptedForReview {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                DispatchQueue.main.async {
                    SKStoreReviewController.requestReview(in: scene)
                }
                UserDefaults.standard.set(currentVersion, forKey: UserDefaults.Keys.lastVersion)
            }
        }
    }
    
    static func incrementNumberOfTimesLaunched() {
        let numberOfTimesLaunched = UserDefaults.standard.integer(forKey: UserDefaults.Keys.numberOfTimesLaunched) + 1
        UserDefaults.standard.set(numberOfTimesLaunched, forKey: UserDefaults.Keys.numberOfTimesLaunched)
    }
}

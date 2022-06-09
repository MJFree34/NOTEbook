//
//  FreeTrialData.swift
//  NOTEbook
//
//  Created by Matt Free on 5/27/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import Foundation

struct FreeTrialData {
    private let nowDate: Date
    
    private lazy var firstLaunchDate = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: UserDefaults.Keys.firstLaunchDate))
    private lazy var twoWeeks = 60.0 * 60.0 * 24.0 * 14.0
    private lazy var freeTrialRemaining = Int(twoWeeks - (nowDate.timeIntervalSince1970 - firstLaunchDate.timeIntervalSince1970))
    
    lazy var daysRemaining: Int = {
        let days = Int(freeTrialRemaining / 60 / 60 / 24)
        if days < 0 {
            return 0
        }
        return days
    }()

    lazy var hoursRemaining: Int = {
        let secondsFromDaysRemaining = daysRemaining * 60 * 60 * 24
        let hours = Int((freeTrialRemaining - secondsFromDaysRemaining) / 60 / 60)
        if hours < 0 {
            return 0
        }
        return hours
    }()

    lazy var minutesRemaining: Int = {
        let secondsFromDaysRemaining = daysRemaining * 60 * 60 * 24
        let secondsFromHoursRemaining = hoursRemaining * 60 * 60
        let minutes = Int((freeTrialRemaining - secondsFromDaysRemaining - secondsFromHoursRemaining) / 60)
        if minutes < 0 {
            return 0
        }
        return minutes
    }()

    lazy var secondsRemaining: Int = {
        let secondsFromDaysRemaining = daysRemaining * 60 * 60 * 24
        let secondsFromHoursRemaining = hoursRemaining * 60 * 60
        let secondsFromMinutesRemaining = minutesRemaining * 60
        let seconds = Int(freeTrialRemaining - secondsFromDaysRemaining - secondsFromHoursRemaining - secondsFromMinutesRemaining)
        if seconds < 0 {
            return 0
        }
        return seconds
    }()
    
    init() {
        nowDate = Date()
    }
}

//
//  Configuration.swift
//  NOTEbook
//
//  Created by Matt Free on 10/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum AppConfiguration {
    case simulator
    case debug
    case testFlight
    case appStore
}

struct Configuration {
    private static let isTestFlight = Bundle.main.appStoreReceiptURL?.lastPathComponent == "sandboxReceipt"
    
    private static var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    private static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    private static var isOnDevice: Bool {
        return isDebug && !isSimulator
    }
    
    static var appConfiguration: AppConfiguration {
        if isDebug {
            return .debug
        } else if isTestFlight {
            return .testFlight
        } else if isSimulator {
            return .simulator
        } else {
            return .appStore
        }
    }
}

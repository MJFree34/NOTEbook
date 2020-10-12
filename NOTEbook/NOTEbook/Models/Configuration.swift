//
//  Configuration.swift
//  NOTEbook
//
//  Created by Matt Free on 10/12/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum AppConfiguration {
    case Debug
    case TestFlight
    case AppStore
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
    
    static var appConfiguration: AppConfiguration {
        if isDebug {
            return .Debug
        } else if isTestFlight {
            return .TestFlight
        } else {
            return .AppStore
        }
    }
}

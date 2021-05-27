//
//  Bundle+Extensions.swift
//  NOTEbook
//
//  Created by Matt Free on 5/27/21.
//  Copyright © 2021 Matt Free. All rights reserved.
//

import Foundation

extension Bundle {
    var appName: String {
        return object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Name"
    }
    
    var appVersion: String {
        return object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
    }

    var buildNumber: Int {
        return Int(object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1") ?? 1
    }
}

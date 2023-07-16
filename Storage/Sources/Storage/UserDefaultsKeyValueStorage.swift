//
//  UserDefaultsKeyValueStorage.swift
//  NOTEbook
//
//  Created by Matt Free on 7/10/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public final class UserDefaultsKeyValueStorage: KeyValueStorage {
    private let userDefaults: UserDefaults

    public init() {
        userDefaults = UserDefaults(suiteName: "NOTEbook") ?? .standard
    }

    public func bool(for key: KeyValueStorageKey) -> Bool {
        userDefaults.bool(forKey: key.rawValue)
    }

    public func set(_ bool: Bool, for key: KeyValueStorageKey) {
        userDefaults.set(bool, forKey: key.rawValue)
    }

    public func register(defaults: [KeyValueStorageKey: Any]) {
        let mappedDefaults = Dictionary(uniqueKeysWithValues: defaults.map { key, value in (key.rawValue, value) })
        userDefaults.register(defaults: mappedDefaults)
    }
}

//
//  UserDefaultsKeyValueStorage.swift
//  NOTEbook
//
//  Created by Matt Free on 7/10/23.
//

import Foundation

final class UserDefaultsKeyValueStorage: KeyValueStorage {
    private let userDefaults: UserDefaults

    init() {
        userDefaults = UserDefaults(suiteName: "NOTEbook") ?? .standard
    }

    func bool(for key: KeyValueStorageKey) -> Bool {
        userDefaults.bool(forKey: key.rawValue)
    }

    func set(_ bool: Bool, for key: KeyValueStorageKey) {
        userDefaults.set(bool, forKey: key.rawValue)
    }

    func register(defaults: [KeyValueStorageKey: Any]) {
        let mappedDefaults = Dictionary(uniqueKeysWithValues: defaults.map { key, value in (key.rawValue, value) })
        userDefaults.register(defaults: mappedDefaults)
    }
}

//
//  UserDefaultsKeyValueStorage.swift
//  NOTEbook
//
//  Created by Matt Free on 7/10/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

// swiftlint:disable discouraged_optional_collection
public final class UserDefaultsKeyValueStorage: KeyValueStorage {
    private let userDefaults: UserDefaults

    public init() {
        userDefaults = UserDefaults(suiteName: "NOTEbook") ?? .standard
    }

    public func bool(for key: KeyValueStorageKey) -> Bool {
        userDefaults.bool(forKey: key.rawValue)
    }

    public func dictionary<T>(for key: KeyValueStorageKey) -> [String : T]? {
        userDefaults.dictionary(forKey: key.rawValue) as? [String : T]
    }

    public func set(_ bool: Bool, for key: KeyValueStorageKey) {
        userDefaults.set(bool, forKey: key.rawValue)
    }

    public func set<T>(_ dictionary: [String : T], for key: KeyValueStorageKey) {
        userDefaults.set(dictionary, forKey: key.rawValue)
    }

    public func register(defaults: [KeyValueStorageKey: Any]) {
        let mappedDefaults = Dictionary(uniqueKeysWithValues: defaults.map { key, value in (key.rawValue, value) })
        userDefaults.register(defaults: mappedDefaults)
    }
}

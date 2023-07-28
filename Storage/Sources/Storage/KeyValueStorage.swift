//
//  KeyValueStorage.swift
//  Storage
//
//  Created by Matt Free on 7/10/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public protocol KeyValueStorage {
    func bool(for key: KeyValueStorageKey) -> Bool
    func dictionary<T>(for key: KeyValueStorageKey) -> [String : T]?

    func set(_ bool: Bool, for key: KeyValueStorageKey)
    func set<T>(_ dictionary: [String : T], for key: KeyValueStorageKey)

    func register(defaults: [KeyValueStorageKey: Any])
}

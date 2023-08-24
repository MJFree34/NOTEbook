//
//  KeyValueStorage.swift
//  NOTEbook
//
//  Created by Matt Free on 7/10/23.
//

import Foundation

protocol KeyValueStorage {
    func bool(for key: KeyValueStorageKey) -> Bool

    func set(_ bool: Bool, for key: KeyValueStorageKey)

    func register(defaults: [KeyValueStorageKey: Any])
}

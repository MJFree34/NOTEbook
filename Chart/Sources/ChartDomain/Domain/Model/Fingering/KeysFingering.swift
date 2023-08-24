//
//  KeysFingering.swift
//  ChartDomain
//
//  Created by Matt Free on 7/18/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

// swiftlint:disable no_fatal_errors
public struct KeysFingering: Fingering {
    private enum CodingKeys: CodingKey {
        case keys
    }

    public var keys: [Bool]

    public var id = UUID()

    public init(keys: [Bool]) {
        self.keys = keys
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(keys)
    }

    public static func initial(for type: FingeringViewType) -> KeysFingering {
        switch type {
        case .baritoneSaxophone:
            return KeysFingering(keys: Array(repeating: false, count: 24))
        case .clarinet:
            return KeysFingering(keys: Array(repeating: false, count: 24))
        case .flute:
            return KeysFingering(keys: Array(repeating: false, count: 16))
        case .fourValve:
            return KeysFingering(keys: Array(repeating: false, count: 4))
        case .saxophone:
            return KeysFingering(keys: Array(repeating: false, count: 23))
        case .threeValve:
            return KeysFingering(keys: Array(repeating: false, count: 3))
        default:
            fatalError("Invalid type for initial KeysFingering.")
        }
    }
}

extension KeysFingering {
    public static var emptyPlaceholder = KeysFingering(keys: Array(repeating: false, count: 24))
    public static var fullPlaceholder = KeysFingering(keys: Array(repeating: true, count: 24))
}

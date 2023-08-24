//
//  KeysTriggersFingering.swift
//  ChartDomain
//
//  Created by Matt Free on 7/18/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

// swiftlint:disable no_fatal_errors
public struct KeysTriggersFingering: Fingering {
    private enum CodingKeys: CodingKey {
        case keys
        case triggers
    }

    public var keys: [Bool]
    public var triggers: [Bool]

    public var id = UUID()

    public init(keys: [Bool], triggers: [Bool]) {
        self.keys = keys
        self.triggers = triggers
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(keys)
        hasher.combine(triggers)
    }

    public static func initial(for type: FingeringViewType) -> KeysTriggersFingering {
        switch type {
        case .bbTriggerThreeValve:
            return KeysTriggersFingering(keys: [false, false, false], triggers: [false])
        default:
            fatalError("Invalid type for initial KeysTriggersFingering.")
        }
    }
}

extension KeysTriggersFingering {
    public static var emptyPlaceholder = KeysTriggersFingering(keys: [false, false, false], triggers: [false])
    public static var fullPlaceholder = KeysTriggersFingering(keys: [true, true, true], triggers: [true])
}

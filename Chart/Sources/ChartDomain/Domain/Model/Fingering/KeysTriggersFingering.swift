//
//  KeysTriggersFingering.swift
//  ChartDomain
//
//  Created by Matt Free on 7/18/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public struct KeysTriggersFingering: Fingering {
    public var keys: [Bool]
    public var triggers: [Bool]

    public var id: UUID { UUID() }

    public init(keys: [Bool], triggers: [Bool]) {
        self.keys = keys
        self.triggers = triggers
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(keys)
        hasher.combine(triggers)
    }
}

extension KeysTriggersFingering {
    public static var emptyPlaceholder = KeysTriggersFingering(keys: [false, false, false], triggers: [false])
    public static var fullPlaceholder = KeysTriggersFingering(keys: [true, true, true], triggers: [true])
}

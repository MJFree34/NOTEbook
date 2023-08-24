//
//  KeysFingering.swift
//  ChartDomain
//
//  Created by Matt Free on 7/18/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public struct KeysFingering: Fingering {
    public var keys: [Bool]

    public var id: UUID { UUID() }

    public init(keys: [Bool]) {
        self.keys = keys
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(keys)
    }
}

extension KeysFingering {
    public static var emptyPlaceholder = KeysFingering(keys: Array(repeating: false, count: 24))
    public static var fullPlaceholder = KeysFingering(keys: Array(repeating: true, count: 24))
}

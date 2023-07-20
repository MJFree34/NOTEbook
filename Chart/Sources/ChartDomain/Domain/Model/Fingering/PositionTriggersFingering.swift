//
//  PositionTriggersFingering.swift
//  ChartDomain
//
//  Created by Matt Free on 7/18/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public struct PositionTriggersFingering: Fingering {
    public var position: Position
    public var triggers: [Bool]

    public var id: UUID { UUID() }

    public init(position: Position, triggers: [Bool]) {
        self.position = position
        self.triggers = triggers
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(position)
        hasher.combine(triggers)
    }
}

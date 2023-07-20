//
//  PositionFingering.swift
//  ChartDomain
//
//  Created by Matt Free on 7/18/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public struct PositionFingering: Fingering {
    public var position: Position

    public var id: UUID { UUID() }

    public init(position: Position) {
        self.position = position
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(position)
    }
}

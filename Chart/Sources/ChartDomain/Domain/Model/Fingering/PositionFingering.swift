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

extension PositionFingering {
    public static var flatPlaceholder = PositionFingering(position: Position(value: .first, type: .flat))
    public static var naturalPlaceholder = PositionFingering(position: Position(value: .fourth, type: .natural))
    public static var sharpPlaceholder = PositionFingering(position: Position(value: .seventh, type: .sharp))
}

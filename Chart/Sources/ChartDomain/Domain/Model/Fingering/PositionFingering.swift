//
//  PositionFingering.swift
//  ChartDomain
//
//  Created by Matt Free on 7/18/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

// swiftlint:disable no_fatal_errors
public struct PositionFingering: Fingering {
    public var position: Position

    public var id: UUID { UUID() }

    public init(position: Position) {
        self.position = position
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(position)
    }

    public static func initial(for type: FingeringViewType) -> PositionFingering {
        switch type {
        case .position:
            return PositionFingering(position: Position(value: .first, type: .natural))
        default:
            fatalError("Invalid type for initial PositionFingering.")
        }
    }
}

extension PositionFingering {
    public static var flatPlaceholder = PositionFingering(position: Position(value: .first, type: .flat))
    public static var naturalPlaceholder = PositionFingering(position: Position(value: .fourth, type: .natural))
    public static var sharpPlaceholder = PositionFingering(position: Position(value: .seventh, type: .sharp))
}

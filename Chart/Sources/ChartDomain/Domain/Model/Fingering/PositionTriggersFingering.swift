//
//  PositionTriggersFingering.swift
//  ChartDomain
//
//  Created by Matt Free on 7/18/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

// swiftlint:disable no_fatal_errors
public struct PositionTriggersFingering: Fingering {
    private enum CodingKeys: CodingKey {
        case position
        case triggers
    }

    public var position: Position
    public var triggers: [Bool]

    public var id = UUID()

    public init(position: Position, triggers: [Bool]) {
        self.position = position
        self.triggers = triggers
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(position)
        hasher.combine(triggers)
    }

    public static func initial(for type: FingeringViewType) -> PositionTriggersFingering {
        switch type {
        case .fTriggerPosition:
            return PositionTriggersFingering(position: Position(value: .first, type: .natural), triggers: [false])
        default:
            fatalError("Invalid type for initial PositionTriggersFingering.")
        }
    }
}

extension PositionTriggersFingering {
    public static var flatPlaceholder = PositionTriggersFingering(position: Position(value: .first, type: .flat), triggers: [false])
    public static var naturalPlaceholder = PositionTriggersFingering(position: Position(value: .fourth, type: .natural), triggers: [true])
    public static var sharpPlaceholder = PositionTriggersFingering(position: Position(value: .seventh, type: .sharp), triggers: [false])
}

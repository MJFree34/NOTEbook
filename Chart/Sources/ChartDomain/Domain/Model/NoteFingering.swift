//
//  NoteFingering.swift
//  ChartDomain
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matthew Free. All rights reserved.
//

import Foundation

public struct NoteFingering {
    public var notes: [Note]
    public var fingerings: [any Fingering]

    public init(notes: [Note], fingerings: [any Fingering]) {
        self.notes = notes
        self.fingerings = fingerings
    }

    public func limit(to limit: Int) -> [any Fingering] {
        let removeAmount = fingerings.count - limit

        if removeAmount > 0 {
            let shortenedFingerings = fingerings[0...fingerings.count - removeAmount - 1]
            return Array(shortenedFingerings)
        }

        return fingerings
    }
}

extension NoteFingering: Identifiable {
    public var id: UUID { UUID() }
}

extension NoteFingering: Equatable {
    public static func == (lhs: NoteFingering, rhs: NoteFingering) -> Bool {
        lhs.notes == rhs.notes && fingeringsEqual(lhsFingerings: lhs.fingerings, rhsFingerings: rhs.fingerings)
    }

    private static func fingeringsEqual(lhsFingerings: [any Fingering], rhsFingerings: [any Fingering]) -> Bool {
        lhsFingerings.elementsEqual(rhsFingerings) { lhsFingering, rhsFingering in
            if let lhsFingering = lhsFingering as? KeysFingering, let rhsFingering = rhsFingering as? KeysFingering {
                return lhsFingering == rhsFingering
            } else if let lhsFingering = lhsFingering as? KeysTriggersFingering, let rhsFingering = rhsFingering as? KeysTriggersFingering {
                return lhsFingering == rhsFingering
            } else if let lhsFingering = lhsFingering as? PositionFingering, let rhsFingering = rhsFingering as? PositionFingering {
                return lhsFingering == rhsFingering
            } else if let lhsFingering = lhsFingering as? PositionTriggersFingering, let rhsFingering = rhsFingering as? PositionTriggersFingering {
                return lhsFingering == rhsFingering
            }
            return false
        }
    }
}

extension NoteFingering: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(notes)
        if let fingerings = fingerings as? [KeysFingering] {
            hasher.combine(fingerings)
        } else if let fingerings = fingerings as? [KeysTriggersFingering] {
            hasher.combine(fingerings)
        } else if let fingerings = fingerings as? [PositionFingering] {
            hasher.combine(fingerings)
        } else if let fingerings = fingerings as? [PositionTriggersFingering] {
            hasher.combine(fingerings)
        }
    }
}

extension NoteFingering: Codable {
    private enum CodingKeys: String, CodingKey {
        case notes
        case keysFingerings
        case keysTriggersFingerings
        case positionFingerings
        case positionTriggersFingerings
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notes = try values.decode([Note].self, forKey: .notes)

        let keysFingerings = try values.decode([KeysFingering].self, forKey: .keysFingerings)
        let keysTriggersFingerings = try values.decode([KeysTriggersFingering].self, forKey: .keysTriggersFingerings)
        let positionFingerings = try values.decode([PositionFingering].self, forKey: .positionFingerings)
        let positionTriggersFingerings = try values.decode([PositionTriggersFingering].self, forKey: .positionTriggersFingerings)
        fingerings = []
        fingerings.append(contentsOf: keysFingerings)
        fingerings.append(contentsOf: keysTriggersFingerings)
        fingerings.append(contentsOf: positionFingerings)
        fingerings.append(contentsOf: positionTriggersFingerings)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(notes, forKey: .notes)

        var keysFingerings: [KeysFingering] = []
        var keysTriggersFingerings: [KeysTriggersFingering] = []
        var positionFingerings: [PositionFingering] = []
        var positionTriggersFingerings: [PositionTriggersFingering] = []

        fingerings.forEach { fingering in
            if let fingering = fingering as? KeysFingering {
                keysFingerings.append(fingering)
            } else if let fingering = fingering as? KeysTriggersFingering {
                keysTriggersFingerings.append(fingering)
            } else if let fingering = fingering as? PositionFingering {
                positionFingerings.append(fingering)
            } else if let fingering = fingering as? PositionTriggersFingering {
                positionTriggersFingerings.append(fingering)
            }
        }

        try container.encode(keysFingerings, forKey: .keysFingerings)
        try container.encode(keysFingerings, forKey: .keysTriggersFingerings)
        try container.encode(keysFingerings, forKey: .positionFingerings)
        try container.encode(keysFingerings, forKey: .positionTriggersFingerings)
    }
}

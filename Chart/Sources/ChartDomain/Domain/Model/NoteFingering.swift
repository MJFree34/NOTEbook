//
//  NoteFingering.swift
//  ChartDomain
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matthew Free. All rights reserved.
//

import Foundation

public struct NoteFingering: Identifiable {
    public var id = UUID()
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
        case fingerings
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notes = try values.decode([Note].self, forKey: .notes)

        let keysFingerings = try? values.decode([KeysFingering].self, forKey: .fingerings)
        let keysTriggersFingerings = try? values.decode([KeysTriggersFingering].self, forKey: .fingerings)
        let positionFingerings = try? values.decode([PositionFingering].self, forKey: .fingerings)
        let positionTriggersFingerings = try? values.decode([PositionTriggersFingering].self, forKey: .fingerings)

        fingerings = []
        if let keysFingerings {
            fingerings.append(contentsOf: keysFingerings)
        } else if let keysTriggersFingerings {
            fingerings.append(contentsOf: keysTriggersFingerings)
        } else if let positionFingerings {
            fingerings.append(contentsOf: positionFingerings)
        } else if let positionTriggersFingerings {
            fingerings.append(contentsOf: positionTriggersFingerings)
        } else {
            throw ChartError.decodingError
        }
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

        if !keysFingerings.isEmpty {
            try container.encode(keysFingerings, forKey: .fingerings)
        } else if !keysTriggersFingerings.isEmpty {
            try container.encode(keysTriggersFingerings, forKey: .fingerings)
        } else if !positionFingerings.isEmpty {
            try container.encode(positionFingerings, forKey: .fingerings)
        } else if !positionTriggersFingerings.isEmpty {
            try container.encode(positionTriggersFingerings, forKey: .fingerings)
        } else {
            try container.encode([KeysFingering](), forKey: .fingerings)
        }
    }
}

extension NoteFingering {
    public static let singleNotePlaceholder = NoteFingering(
        notes: [
            Note(letter: .c, type: .natural, octave: .four, clef: .treble)
        ],
        fingerings: []
    )

    public static let doubleNotePlaceholder = NoteFingering(
        notes: [
            Note(letter: .c, type: .sharp, octave: .four, clef: .treble),
            Note(letter: .d, type: .flat, octave: .four, clef: .treble)
        ],
        fingerings: []
    )
}

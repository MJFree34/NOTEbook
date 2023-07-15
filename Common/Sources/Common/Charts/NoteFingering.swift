//
//  NoteFingering.swift
//  NoteLibrary
//
//  Created by Matt Free on 6/16/20.
//
import Foundation

public struct NoteFingering: Codable, Equatable {
    public var notes: [Note]
    public var fingerings: [Fingering]

    public static func == (lhs: NoteFingering, rhs: NoteFingering) -> Bool {
        return lhs.notes == rhs.notes && lhs.fingerings == rhs.fingerings
    }

    public func limit(to limit: Int) -> [Fingering] {
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

extension NoteFingering: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(notes)
        hasher.combine(fingerings)
    }
}

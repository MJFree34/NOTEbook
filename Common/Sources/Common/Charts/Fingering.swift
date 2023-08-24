//
//  Fingering.swift
//  NoteLibrary
//
//  Created by Matt Free on 6/16/20.
//

import Foundation

public struct Fingering: Codable, Equatable {
    public var keys: [Bool]?
    public var position: Position?
    public var triggers: [Bool]?

    public init (keys: [Bool]? = nil, position: Position? = nil, triggers: [Bool]? = nil) {
        self.keys = keys
        self.position = position
        self.triggers = triggers
    }
}

extension Fingering: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(keys)
        hasher.combine(position)
        hasher.combine(triggers)
    }
}

extension Fingering: Identifiable {
    public var id: UUID { UUID() }
}

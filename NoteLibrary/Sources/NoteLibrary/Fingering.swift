//
//  Fingering.swift
//  NoteLibrary
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//
import Foundation

struct Fingering: Codable, Equatable {
    var keys: [Bool]?
    var position: Position?
    var triggers: [Bool]?
}

extension Fingering: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(keys)
        hasher.combine(position)
        hasher.combine(triggers)
    }
}

extension Fingering: Identifiable {
    var id: UUID { UUID() }
}

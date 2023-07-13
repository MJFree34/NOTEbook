//
//  Position.swift
//  NoteLibrary
//
//  Created by Matt Free on 8/21/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

struct Position: Codable, Equatable {
    enum Value: String, Codable, CaseIterable {
        case none = "none"
        case first = "1st"
        case second = "2nd"
        case third = "3rd"
        case fourth = "4th"
        case fifth = "5th"
        case sixth = "6th"
        case seventh = "7th"
    }

    var value: Value
    var type: NoteType
}

extension Position: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(type)
    }
}

extension Position.Value: Identifiable {
    var id: String { rawValue }
}

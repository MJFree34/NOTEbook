//
//  Position.swift
//  ChartDomain
//
//  Created by Matt Free on 8/21/20.
//  Copyright © 2020 Matthew Free. All rights reserved.
//

import Foundation

public struct Position: Codable, Equatable {
    public enum Value: String, Codable, CaseIterable {
        case first = "1st"
        case second = "2nd"
        case third = "3rd"
        case fourth = "4th"
        case fifth = "5th"
        case sixth = "6th"
        case seventh = "7th"
    }

    public var value: Value
    public var type: NoteType

    public init(value: Value, type: NoteType) {
        self.value = value
        self.type = type
    }
}

extension Position: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(type)
    }
}

extension Position.Value: Identifiable {
    public var id: String { rawValue }
}

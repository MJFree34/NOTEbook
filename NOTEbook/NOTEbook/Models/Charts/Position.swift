//
//  Position.swift
//  NOTEbook
//
//  Created by Matt Free on 8/21/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum PositionValue: String, Codable {
    case first = "1st"
    case second = "2nd"
    case third = "3rd"
    case fourth = "4th"
    case fifth = "5th"
    case sixth = "6th"
    case seventh = "7th"
}

struct Position: Codable, Equatable {
    var value: PositionValue
    var type: NoteType
}

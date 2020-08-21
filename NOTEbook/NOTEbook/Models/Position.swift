//
//  Position.swift
//  NOTEbook
//
//  Created by Matt Free on 8/21/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum PositionValue: String, Decodable {
    case first = "1"
    case second = "2"
    case third = "3"
    case fourth = "4"
    case fifth = "5"
    case sixth = "6"
    case seventh = "7"
}

struct Position: Decodable, Equatable {
    var value: PositionValue
    var type: NoteType
}

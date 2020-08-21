//
//  Fingering.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum Position: String, Decodable {
    case first = "1"
    case second = "2"
    case third = "3"
    case fourth = "4"
    case fifth = "5"
    case sixth = "6"
    case seventh = "7"
    case flatFirst = "b1"
    case flatSecond = "b2"
    case flatThird = "b3"
    case flatFourth = "b4"
    case flatFifth = "b5"
    case flatSixth = "b6"
    case flatSeventh = "b7"
    case sharpFirst = "#1"
    case sharpSecond = "#2"
    case sharpThird = "#3"
    case sharpFourth = "#4"
    case sharpFifth = "#5"
    case sharpSixth = "#6"
    case sharpSeventh = "#7"
}

struct Fingering: Decodable, Equatable {
    var keys: [Bool]?
    var position: Position?
}

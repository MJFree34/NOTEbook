//
//  NoteOctave.swift
//  ChartDomain
//
//  Created by Matt Free on 7/11/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

// swiftlint:disable sorted_enum_cases
public enum NoteOctave: Int, Codable {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
}

extension NoteOctave: Comparable {
    public static func < (lhs: NoteOctave, rhs: NoteOctave) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

//
//  NoteOctave.swift
//  NoteLibrary
//
//  Created by Matt Free on 7/11/23.
//

import Foundation

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

    public func octaveNumber() -> Int {
        switch self {
        case .zero:
            return 0
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        }
    }
}

//
//  NoteLetter.swift
//  NoteLibrary
//
//  Created by Matt Free on 7/11/23.
//

import Foundation

public enum NoteLetter: String, Codable {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
}

extension NoteLetter: Comparable {
    public static func < (lhs: NoteLetter, rhs: NoteLetter) -> Bool {
        switch lhs {
        case .c:
            return rhs != .c
        case .d:
            return rhs != .c || rhs != .d
        case .e:
            return rhs != .c || rhs != .d || rhs != .e
        case .f:
            return rhs == .g || rhs == .a || rhs == .b
        case .g:
            return rhs == .a || rhs == .b
        case .a:
            return rhs == .b
        case .b:
            return false
        }
    }
}

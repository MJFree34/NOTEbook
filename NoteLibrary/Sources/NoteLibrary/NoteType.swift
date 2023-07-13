//
//  NoteType.swift
//  NoteLibrary
//
//  Created by Matt Free on 7/11/23.
//

import Foundation

enum NoteType: String, Codable {
    case flat
    case natural
    case sharp
}

extension NoteType: Comparable {
    static func < (lhs: NoteType, rhs: NoteType) -> Bool {
        switch lhs {
        case .flat:
            return rhs != .flat
        case .natural:
            return rhs == .sharp
        case .sharp:
            return false
        }
    }
}

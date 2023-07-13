//
//  Clef.swift
//  NoteLibrary
//
//  Created by Matt Free on 7/11/23.
//

import Foundation

enum Clef: String, Codable, CaseIterable {
    case bass
    case treble
}

extension Clef: Identifiable {
    var id: String { rawValue }
}

extension Clef: Comparable {
    static func < (lhs: Clef, rhs: Clef) -> Bool {
        switch lhs {
        case .bass:
            return rhs == .treble
        case .treble:
            return false
        }
    }
}

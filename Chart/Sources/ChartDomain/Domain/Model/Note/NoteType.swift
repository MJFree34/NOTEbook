//
//  NoteType.swift
//  ChartDomain
//
//  Created by Matt Free on 7/11/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public enum NoteType: String, Codable {
    case flat
    case natural
    case sharp
}

extension NoteType: Comparable {
    public static func < (lhs: NoteType, rhs: NoteType) -> Bool {
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

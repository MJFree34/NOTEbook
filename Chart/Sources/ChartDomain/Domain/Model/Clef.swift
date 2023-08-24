//
//  Clef.swift
//  ChartDomain
//
//  Created by Matt Free on 7/11/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public enum Clef: String, Codable, CaseIterable {
    case bass
    case treble
}

extension Clef: Identifiable {
    public var id: String { rawValue }
}

extension Clef: Comparable {
    public static func < (lhs: Clef, rhs: Clef) -> Bool {
        switch lhs {
        case .bass:
            return rhs == .treble
        case .treble:
            return false
        }
    }
}

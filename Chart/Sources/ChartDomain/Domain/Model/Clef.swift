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
    case alto
    case treble
}

extension Clef: Identifiable {
    public var id: String { rawValue }
}

extension Clef: Comparable {
    private var sortOrder: Int {
        switch self {
        case .bass:
            return 0
        case .alto:
            return 1
        case .treble:
            return 2
        }
    }

    public static func < (lhs: Clef, rhs: Clef) -> Bool {
        lhs.sortOrder < rhs.sortOrder
    }
}

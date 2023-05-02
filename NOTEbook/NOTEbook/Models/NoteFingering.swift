//
//  NoteFingering.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//
import Foundation

struct NoteFingering: Codable, Equatable {
    var notes: [Note]
    var fingerings: [Fingering]
    
    static func == (lhs: NoteFingering, rhs: NoteFingering) -> Bool {
        return lhs.notes == rhs.notes && lhs.fingerings == rhs.fingerings
    }
    
    func shorten(to limit: Int) -> [Fingering] {
        let removeAmount = fingerings.count - limit
        
        if removeAmount > 0 {
            let shortenedFingerings = fingerings[0...fingerings.count - removeAmount - 1]
            return Array(shortenedFingerings)
        }
        
        return fingerings
    }
}

extension NoteFingering: Identifiable {
    var id: UUID { UUID() }
}

extension NoteFingering: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(notes)
        hasher.combine(fingerings)
    }
}

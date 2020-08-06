//
//  NoteFingering.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

struct NoteFingering: Decodable, Equatable {
    var notes: [Note]
    var fingerings: [Fingering]
    
    static func == (lhs: NoteFingering, rhs: NoteFingering) -> Bool {
        return lhs.notes == rhs.notes && lhs.fingerings == rhs.fingerings
    }
}

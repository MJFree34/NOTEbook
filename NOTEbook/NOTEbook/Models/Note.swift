//
//  Note.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum NoteLetter: String, Codable {
    case a, b, c, d, e, f, g
}

enum NoteType: String, Codable {
    case natural
    case sharp
    case flat
}

enum NoteOctave: String, Codable {
    case zero, one, two, three, four, five, six, seven
}

enum LineLocation: String, Codable {
    case top, bottom, none
}

struct Note: Codable {
    var letter: NoteLetter
    var type: NoteType
    var octave: NoteOctave
    var numberOfExtraLines: Int
    var extraLinesLocation: LineLocation
}

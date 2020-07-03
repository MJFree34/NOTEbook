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
    
    func previousOctave() -> NoteOctave {
        switch self {
        case .zero:
            return .zero
        case .one:
            return .zero
        case .two:
            return .one
        case .three:
            return .two
        case .four:
            return .three
        case .five:
            return .four
        case .six:
            return .five
        case .seven:
            return .six
        }
    }
    
    func nextOctave() -> NoteOctave {
        switch self {
        case .zero:
            return .one
        case .one:
            return .two
        case .two:
            return .three
        case .three:
            return .four
        case .four:
            return .five
        case .five:
            return .six
        case .six:
            return .seven
        case .seven:
            return .seven
        }
    }
}

enum LineLocation: String, Codable {
    case top, bottom, none
}

struct Note: Codable, Equatable {
    var letter: NoteLetter
    var type: NoteType
    var octave: NoteOctave
    
    lazy var numberOfExtraLines: Int = {
        switch octave {
        case .three:
            if self.letter == .c || self.letter == .d {
                return 4
            } else if self.letter == .e || self.letter == .f {
                return 3
            } else if self.letter == .g || self.letter == .a {
                return 2
            }
            return 1
        case .four:
            if self.letter == .c {
                return 1
            }
            return 0
        case .five:
            if self.letter == .a || self.letter == .b {
                return 1
            }
            return 0
        case .six:
            if self.letter == .d || self.letter == .c {
                return 2
            } else if self.letter == .e || self.letter == .f {
                return 3
            }
            return 0
        case .seven, .zero, .one, .two:
            return 0
        }
    }()
    
    lazy var extraLinesLocation: LineLocation = {
        if self.octave == .three || (self.octave == .four && self.letter == .c) {
            return .bottom
        } else if self.octave == .four || (self.octave == .five && (self.letter != .a && self.letter != .b)) {
            return .none
        } else {
            return .top
        }
    }()
    
    init(letter: NoteLetter, type: NoteType, octave: NoteOctave) {
        self.letter = letter
        self.type = type
        self.octave = octave
    }
    
    func previousNote() -> Note {
        var newNote = self
        
        switch self.letter {
        case .a:
            if self.octave == .five && self.type == .flat {
                newNote.numberOfExtraLines = 0
                newNote.extraLinesLocation = .none
            }
            
            switch self.type {
            case .natural:
                newNote.type = .flat
            case .sharp:
                newNote.type = .natural
            case .flat:
                newNote.type = .natural
                newNote.letter = .g
            }
        case .b:
            if self.octave == .three && self.type == .flat {
                newNote.numberOfExtraLines = 2
                newNote.extraLinesLocation = .bottom
            } else if self.octave == .five && self.type == .flat {
                newNote.numberOfExtraLines = 1
                newNote.extraLinesLocation = .top
            }
            
            switch self.type {
            case .natural:
                newNote.type = .flat
            case .sharp:
                newNote.type = .natural
            case .flat:
                newNote.type = .natural
                newNote.letter = .a
            }
        case .c:
            if self.octave == .six && self.type != .sharp {
                newNote.numberOfExtraLines = 1
                newNote.extraLinesLocation = .top
            } else if octave == .three && self.type != .sharp {
                break
            }
            
            switch self.type {
            case .natural:
                newNote.letter = .b
                newNote.octave = self.octave.previousOctave()
            case .sharp:
                newNote.type = .natural
            case .flat:
                fatalError()
            }
        case .d:
            if self.octave == .four && self.type == .flat {
                newNote.numberOfExtraLines = 1
                newNote.extraLinesLocation = .bottom
            }
            
            switch self.type {
            case .natural:
                newNote.type = .flat
            case .sharp:
                newNote.type = .natural
            case .flat:
                newNote.type = .natural
                newNote.letter = .c
            }
        case .e:
            if self.octave == .three && self.type == .flat {
                newNote.numberOfExtraLines = 4
                newNote.extraLinesLocation = .bottom
            } else if self.octave == .six && self.type == .flat {
                newNote.numberOfExtraLines = 2
                newNote.extraLinesLocation = .top
            }
            
            switch self.type {
            case .natural:
                newNote.type = .flat
            case .sharp:
                fatalError()
            case .flat:
                newNote.type = .natural
                newNote.letter = .d
            }
        case .f:
            if self.octave == .six && self.type != .sharp {
                newNote.numberOfExtraLines = 3
                newNote.extraLinesLocation = .top
            }
            
            switch self.type {
            case .natural:
                newNote.letter = .e
            case .sharp:
                newNote.type = .natural
            case .flat:
                fatalError()
            }
        case .g:
            if self.octave == .three && self.type == .flat {
                newNote.numberOfExtraLines = 3
                newNote.extraLinesLocation = .bottom
            }
            
            switch self.type {
            case .natural:
                newNote.type = .flat
            case .sharp:
                newNote.type = .natural
            case .flat:
                newNote.type = .natural
                newNote.letter = .f
            }
        }
        
        return newNote
    }
    
    func nextNote() -> Note {
        var newNote = self
        
        switch self.letter {
        case .a:
            if self.octave == .three && self.type == .sharp {
                newNote.numberOfExtraLines = 1
                newNote.extraLinesLocation = .bottom
            }
            
            switch self.type {
            case .natural:
                newNote.type = .sharp
            case .sharp:
                newNote.type = .natural
                newNote.letter = .b
            case .flat:
                newNote.type = .natural
            }
        case .b:
            if self.octave == .five && self.type != .flat {
                newNote.numberOfExtraLines = 2
                newNote.extraLinesLocation = .top
            }
            
            switch self.type {
            case .natural:
                newNote.letter = .c
                newNote.octave = self.octave.nextOctave()
            case .sharp:
                fatalError()
            case .flat:
                newNote.type = .natural
            }
        case .c:
            if self.octave == .four && self.type != .sharp {
                newNote.numberOfExtraLines = 1
                newNote.extraLinesLocation = .bottom
            }
            
            switch self.type {
            case .natural:
                newNote.type = .sharp
            case .sharp:
                newNote.type = .natural
                newNote.letter = .d
            case .flat:
                fatalError()
            }
        case .d:
            if self.octave == .three && self.type == .sharp {
                newNote.numberOfExtraLines = 3
                newNote.extraLinesLocation = .bottom
            } else if self.octave == .six && self.type == .sharp {
                newNote.numberOfExtraLines = 3
                newNote.extraLinesLocation = .top
            }
            
            switch self.type {
            case .natural:
                newNote.type = .sharp
            case .sharp:
                newNote.type = .natural
                newNote.letter = .e
            case .flat:
                newNote.type = .natural
            }
        case .e:
            if self.octave == .three && self.type == .flat {
                newNote.numberOfExtraLines = 4
                newNote.extraLinesLocation = .bottom
            } else if self.octave == .six && self.type == .flat {
                newNote.numberOfExtraLines = 2
                newNote.extraLinesLocation = .top
            }
            
            switch self.type {
            case .natural:
                newNote.type = .natural
                newNote.letter = .f
            case .sharp:
                fatalError()
            case .flat:
                newNote.type = .natural
            }
        case .f:
            if self.octave == .three && self.type != .sharp {
                newNote.numberOfExtraLines = 2
                newNote.extraLinesLocation = .bottom
            } else if self.octave == .six {
                break
            }
            
            switch self.type {
            case .natural:
                newNote.type = .sharp
            case .sharp:
                newNote.type = .natural
                newNote.letter = .g
            case .flat:
                fatalError()
            }
        case .g:
            if self.octave == .five && self.type == .sharp {
                newNote.numberOfExtraLines = 1
                newNote.extraLinesLocation = .top
            }
            
            switch self.type {
            case .natural:
                newNote.type = .sharp
            case .sharp:
                newNote.type = .natural
                newNote.letter = .a
            case .flat:
                newNote.type = .natural
            }
        }
        
        return newNote
    }
    
    func capitalizedLetter(from noteType: NoteType) -> String {
        switch self.letter {
        case .b:
            if noteType == .flat && self.type != .flat {
                return NoteLetter.c.rawValue.capitalized
            }
        case .c:
            if noteType == .sharp && self.type != .sharp {
                return NoteLetter.b.rawValue.capitalized
            }
        case .e:
            if noteType == .flat && self.type != .flat {
                return NoteLetter.f.rawValue.capitalized
            }
        case .f:
            if noteType == .sharp && self.type != .sharp {
                return NoteLetter.e.rawValue.capitalized
            }
        case .a, .d, .g:
            break
        }
        return self.letter.rawValue.capitalized
    }
}

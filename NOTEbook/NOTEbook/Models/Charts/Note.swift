//
//  Note.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum NoteLetter: String, Decodable {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
}

enum NoteType: String, Decodable {
    case natural
    case sharp
    case flat
}

enum Clef: String, Decodable {
    case bass
    case treble
}

enum NotePosition: String, Decodable {
    case bottom8thLine
    case bottom8thSpace
    case bottom7thLine
    case bottom7thSpace
    case bottom6thLine
    case bottom6thSpace
    case bottom5thLine
    case bottom5thSpace
    case bottom4thLine
    case bottom4thSpace
    case bottom3rdLine
    case bottom3rdSpace
    case bottom2ndLine
    case bottom2ndSpace
    case bottom1stLine
    case bottom1stSpace
    case middle1stLine
    case middle1stSpace
    case middle2ndLine
    case middle2ndSpace
    case middle3rdLine
    case middle3rdSpace
    case middle4thLine
    case middle4thSpace
    case middle5thLine
    case top1stSpace
    case top1stLine
    case top2ndSpace
    case top2ndLine
    case top3rdSpace
    case top3rdLine
    case top4thSpace
    case top4thLine
    case top5thSpace
    case top5thLine
    case top6thSpace
    case top6thLine
    case top7thSpace
    case top7thLine
    case top8thSpace
}

enum NoteOctave: String, Decodable {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
}

struct Note: Decodable, Equatable {
    private(set) var letter: NoteLetter
    private(set) var type: NoteType
    private(set) var octave: NoteOctave
    private(set) var clef: Clef
    private(set) var position: NotePosition
    
    enum CodingKeys: String, CodingKey {
        case letter
        case type
        case octave
        case clef
        case position
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        letter = try container.decode(NoteLetter.self, forKey: .letter)
        type = try container.decode(NoteType.self, forKey: .type)
        octave = try container.decode(NoteOctave.self, forKey: .octave)
        clef = try container.decode(Clef.self, forKey: .clef)
        position = Note.calculatePosition(letter: letter, octave: octave, clef: clef)
    }
    
    init(letter: NoteLetter, type: NoteType, octave: NoteOctave, clef: Clef) {
        self.letter = letter
        self.type = type
        self.octave = octave
        self.clef = clef
        self.position = Note.calculatePosition(letter: letter, octave: octave, clef: clef)
    }
    
    private static func calculatePosition(letter: NoteLetter, octave: NoteOctave, clef: Clef) -> NotePosition {
        switch clef {
        case .bass:
            switch letter {
            case .a:
                switch octave {
                case .zero:
                    return .bottom7thSpace
                case .one:
                    return .bottom3rdLine
                case .two:
                    return .middle1stSpace
                case .three:
                    return .middle5thLine
                case .four:
                    return .top4thSpace
                case .five:
                    return .top7thLine
                case .six:
                    fatalError("Note not implemented")
                case .seven:
                    fatalError("Note not implemented")
                case .eight:
                    fatalError("Note not implemented")
                }
            case .b:
                switch octave {
                case .zero:
                    return .bottom6thLine
                case .one:
                    return .bottom3rdSpace
                case .two:
                    return .middle2ndLine
                case .three:
                    return .top1stSpace
                case .four:
                    return .top4thLine
                case .five:
                    fatalError("Note not implemented")
                case .six:
                    fatalError("Note not implemented")
                case .seven:
                    fatalError("Note not implemented")
                case .eight:
                    fatalError("Note not implemented")
                }
            case .c:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    return .bottom6thSpace
                case .two:
                    return .bottom2ndLine
                case .three:
                    return .middle2ndSpace
                case .four:
                    return .top1stLine
                case .five:
                    return .top5thSpace
                case .six:
                    fatalError("Note not implemented")
                case .seven:
                    fatalError("Note not implemented")
                case .eight:
                    fatalError("Note not implemented")
                }
            case .d:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    return .bottom5thLine
                case .two:
                    return .bottom2ndSpace
                case .three:
                    return .middle3rdLine
                case .four:
                    return .top2ndSpace
                case .five:
                    return .top5thLine
                case .six:
                    fatalError("Note not implemented")
                case .seven:
                    fatalError("Note not implemented")
                case .eight:
                    fatalError("Note not implemented")
                }
            case .e:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    return .bottom5thSpace
                case .two:
                    return .bottom1stLine
                case .three:
                    return .middle3rdSpace
                case .four:
                    return .top2ndLine
                case .five:
                    return .top6thSpace
                case .six:
                    fatalError("Note not implemented")
                case .seven:
                    fatalError("Note not implemented")
                case .eight:
                    fatalError("Note not implemented")
                }
            case .f:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    return .bottom4thLine
                case .two:
                    return .bottom1stSpace
                case .three:
                    return .middle4thLine
                case .four:
                    return .top3rdSpace
                case .five:
                    return .top6thLine
                case .six:
                    fatalError("Note not implemented")
                case .seven:
                    fatalError("Note not implemented")
                case .eight:
                    fatalError("Note not implemented")
                }
            case .g:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    return .bottom4thSpace
                case .two:
                    return .middle1stLine
                case .three:
                    return .middle4thSpace
                case .four:
                    return .top3rdLine
                case .five:
                    return .top7thSpace
                case .six:
                    fatalError("Note not implemented")
                case .seven:
                    fatalError("Note not implemented")
                case .eight:
                    fatalError("Note not implemented")
                }
            }
        case .treble:
            switch letter {
            case .a:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    fatalError("Note not implemented")
                case .two:
                    return .bottom6thSpace
                case .three:
                    return .bottom2ndLine
                case .four:
                    return .middle2ndSpace
                case .five:
                    return .top1stLine
                case .six:
                    return .top5thSpace
                case .seven:
                    fatalError("Note not implemented")
                case .eight:
                    fatalError("Note not implemented")
                }
            case .b:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    fatalError("Note not implemented")
                case .two:
                    return .bottom5thLine
                case .three:
                    return .bottom2ndSpace
                case .four:
                    return .middle3rdLine
                case .five:
                    return .top2ndSpace
                case .six:
                    return .top5thLine
                case .seven:
                    fatalError("Note not implemented")
                case .eight:
                    fatalError("Note not implemented")
                }
            case .c:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    fatalError("Note not implemented")
                case .two:
                    return .bottom8thLine
                case .three:
                    return .bottom5thSpace
                case .four:
                    return .bottom1stLine
                case .five:
                    return .middle3rdSpace
                case .six:
                    return .top2ndLine
                case .seven:
                    return .top6thSpace
                case .eight:
                    fatalError("Note not implemented")
                }
            case .d:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    fatalError("Note not implemented")
                case .two:
                    return .bottom8thSpace
                case .three:
                    return .bottom4thLine
                case .four:
                    return .bottom1stSpace
                case .five:
                    return .middle4thLine
                case .six:
                    return .top3rdSpace
                case .seven:
                    return .top6thLine
                case .eight:
                    fatalError("Note not implemented")
                }
            case .e:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    fatalError("Note not implemented")
                case .two:
                    return .bottom7thLine
                case .three:
                    return .bottom4thSpace
                case .four:
                    return .middle1stLine
                case .five:
                    return .middle4thSpace
                case .six:
                    return .top3rdLine
                case .seven:
                    return .top7thSpace
                case .eight:
                    fatalError("Note not implemented")
                }
            case .f:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    fatalError("Note not implemented")
                case .two:
                    return .bottom7thSpace
                case .three:
                    return .bottom3rdLine
                case .four:
                    return .middle1stSpace
                case .five:
                    return .middle5thLine
                case .six:
                    return .top4thSpace
                case .seven:
                    return .top7thLine
                case .eight:
                    fatalError("Note not implemented")
                }
            case .g:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    fatalError("Note not implemented")
                case .two:
                    return .bottom6thLine
                case .three:
                    return .bottom3rdSpace
                case .four:
                    return .middle2ndLine
                case .five:
                    return .top1stSpace
                case .six:
                    return .top4thLine
                case .seven:
                    return .top8thSpace
                case .eight:
                    fatalError("Note not implemented")
                }
            }
        }
    }
    
    func capitalizedLetter() -> String {
        return self.letter.rawValue.capitalized
    }
}

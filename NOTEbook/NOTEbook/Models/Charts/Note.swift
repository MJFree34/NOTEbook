//
//  Note.swift
//  NOTEbook
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum NoteLetter: String, Codable {
    case a
    case b
    case c
    case d
    case e
    case f
    case g
}

enum NoteType: String, Codable {
    case natural
    case sharp
    case flat
}

enum Clef: String, Codable {
    case bass
    case treble
}

enum NotePosition: Int, Comparable {
    case bottom8thLine // 0
    case bottom8thSpace // 1
    case bottom7thLine // 2
    case bottom7thSpace // 3
    case bottom6thLine // 4
    case bottom6thSpace // 5
    case bottom5thLine // 6
    case bottom5thSpace // 7
    case bottom4thLine // 8
    case bottom4thSpace // 9
    case bottom3rdLine // 10
    case bottom3rdSpace // 11
    case bottom2ndLine // 12
    case bottom2ndSpace // 13
    case bottom1stLine // 14
    case bottom1stSpace // 15
    case middle1stLine // 16
    case middle1stSpace // 17
    case middle2ndLine // 18
    case middle2ndSpace // 19
    case middle3rdLine // 20
    case middle3rdSpace // 21
    case middle4thLine // 22
    case middle4thSpace // 23
    case middle5thLine // 24
    case top1stSpace // 25
    case top1stLine // 26
    case top2ndSpace // 27
    case top2ndLine // 28
    case top3rdSpace // 29
    case top3rdLine // 30
    case top4thSpace // 31
    case top4thLine // 32
    case top5thSpace // 33
    case top5thLine // 34
    case top6thSpace // 35
    case top6thLine // 36
    case top7thSpace // 37
    case top7thLine // 38
    case top8thSpace // 39
    
    static func < (lhs: NotePosition, rhs: NotePosition) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

enum NoteOctave: String, Codable {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    
    func octaveNumber() -> Int {
        switch self {
        case .zero:
            return 0
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        case .seven:
            return 7
        case .eight:
            return 8
        }
    }
}

struct Note: Codable, Equatable {
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
    
    func isLowerQuarterNote() -> Bool {
        return position >= NotePosition.middle3rdLine
    }
    
    func capitalizedLetter() -> String {
        return self.letter.rawValue.capitalized
    }
    
    func positionsFromCenterStaff() -> Int {
        return position.rawValue - NotePosition.middle3rdLine.rawValue
    }
}

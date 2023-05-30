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

extension NoteLetter: Comparable {
    static func < (lhs: NoteLetter, rhs: NoteLetter) -> Bool {
        switch lhs {
        case .c:
            return rhs != .c
        case .d:
            return rhs != .c || rhs != .d
        case .e:
            return rhs != .c || rhs != .d || rhs != .e
        case .f:
            return rhs == .g || rhs == .a || rhs == .b
        case .g:
            return rhs == .a || rhs == .b
        case .a:
            return rhs == .b
        case .b:
            return false
        }
    }
}

enum NoteType: String, Codable {
    case natural
    case sharp
    case flat
}

extension NoteType: Comparable {
    static func < (lhs: NoteType, rhs: NoteType) -> Bool {
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

enum NotePosition: Int, Comparable {
    case bottom9thSpace
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
    case top8thLine
    
    static func < (lhs: NotePosition, rhs: NotePosition) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

enum NoteOctave: Int, Codable {
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
                    return .top8thSpace
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
                    return .bottom8thSpace
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
                    return .bottom8thLine
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
                    return .bottom7thSpace
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
                    return .bottom7thLine
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
                    return .top8thLine
                case .eight:
                    fatalError("Note not implemented")
                }
            case .b:
                switch octave {
                case .zero:
                    fatalError("Note not implemented")
                case .one:
                    return .bottom9thSpace
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
    
    static func middleNote(for clef: Clef) -> Note {
        switch clef {
        case .bass:
            return Note(letter: .d, type: .natural, octave: .three, clef: .bass)
        case .treble:
            return Note(letter: .b, type: .natural, octave: .four, clef: .treble)
        }
    }
    
    static func minNote(for clef: Clef) -> Note {
        switch clef {
        case .bass:
            return Note(letter: .e, type: .natural, octave: .zero, clef: .bass)
        case .treble:
            return Note(letter: .c, type: .natural, octave: .two, clef: .treble)
        }
    }
    
    static func maxNote(for clef: Clef) -> Note {
        switch clef {
        case .bass:
            return Note(letter: .a, type: .natural, octave: .five, clef: .bass)
        case .treble:
            return Note(letter: .g, type: .natural, octave: .seven, clef: .treble)
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
    
    func lowerNote() -> Note {
        assert(type == .natural)
        
        let newLetter: NoteLetter
        
        switch letter {
        case .a:
            newLetter = .g
        case .b:
            newLetter = .a
        case .c:
            newLetter = .b
        case .d:
            newLetter = .c
        case .e:
            newLetter = .d
        case .f:
            newLetter = .e
        case .g:
            newLetter = .f
        }
        
        let newOctave: NoteOctave
        
        if letter == .c {
            newOctave = NoteOctave(rawValue: octave.rawValue - 1) ?? octave
        } else {
            newOctave = octave
        }
        
        return Note(letter: newLetter, type: .natural, octave: newOctave, clef: clef)
    }
    
    func higherNote() -> Note {
        assert(type == .natural)
        
        let newLetter: NoteLetter
        
        switch letter {
        case .a:
            newLetter = .b
        case .b:
            newLetter = .c
        case .c:
            newLetter = .d
        case .d:
            newLetter = .e
        case .e:
            newLetter = .f
        case .f:
            newLetter = .g
        case .g:
            newLetter = .a
        }
        
        let newOctave: NoteOctave
        
        if letter == .b {
            newOctave = NoteOctave(rawValue: octave.rawValue + 1) ?? octave
        } else {
            newOctave = octave
        }
        
        return Note(letter: newLetter, type: .natural, octave: newOctave, clef: clef)
    }
    
    func transposeUpHalfStep() -> Note {
        let newLetter: NoteLetter
        let newType: NoteType
        let newOctave: NoteOctave
        
        switch letter {
        case .a:
            switch type {
            case .flat:
                newLetter = .a
                newType = .natural
                newOctave = octave
            case .natural:
                newLetter = .a
                newType = .sharp
                newOctave = octave
            case .sharp:
                newLetter = .b
                newType = .natural
                newOctave = octave
            }
        case .b:
            switch type {
            case .flat:
                newLetter = .b
                newType = .natural
                newOctave = octave
            case .natural:
                newLetter = .c
                newType = .natural
                newOctave = NoteOctave(rawValue: octave.rawValue + 1) ?? octave
            case .sharp:
                fatalError("Note does not exist")
            }
        case .c:
            switch type {
            case .flat:
                fatalError("Note does not exist")
            case .natural:
                newLetter = .c
                newType = .sharp
                newOctave = octave
            case .sharp:
                newLetter = .d
                newType = .natural
                newOctave = octave
            }
        case .d:
            switch type {
            case .flat:
                newLetter = .d
                newType = .natural
                newOctave = octave
            case .natural:
                newLetter = .d
                newType = .sharp
                newOctave = octave
            case .sharp:
                newLetter = .e
                newType = .natural
                newOctave = octave
            }
        case .e:
            switch type {
            case .flat:
                newLetter = .e
                newType = .natural
                newOctave = octave
            case .natural:
                newLetter = .f
                newType = .natural
                newOctave = octave
            case .sharp:
                fatalError("Note does not exist")
            }
        case .f:
            switch type {
            case .flat:
                fatalError("Note does not exist")
            case .natural:
                newLetter = .f
                newType = .sharp
                newOctave = octave
            case .sharp:
                newLetter = .g
                newType = .natural
                newOctave = octave
            }
        case .g:
            switch type {
            case .flat:
                newLetter = .g
                newType = .natural
                newOctave = octave
            case .natural:
                newLetter = .g
                newType = .sharp
                newOctave = octave
            case .sharp:
                newLetter = .a
                newType = .natural
                newOctave = octave
            }
        }
        
        return Note(letter: newLetter, type: newType, octave: newOctave, clef: clef)
    }
    
    func transposeDownHalfStep() -> Note {
        let newLetter: NoteLetter
        let newType: NoteType
        let newOctave: NoteOctave
        
        switch letter {
        case .a:
            switch type {
            case .flat:
                newLetter = .g
                newType = .natural
                newOctave = octave
            case .natural:
                newLetter = .a
                newType = .flat
                newOctave = octave
            case .sharp:
                newLetter = .a
                newType = .natural
                newOctave = octave
            }
        case .b:
            switch type {
            case .flat:
                newLetter = .a
                newType = .natural
                newOctave = octave
            case .natural:
                newLetter = .b
                newType = .flat
                newOctave = octave
            case .sharp:
                fatalError("Note does not exist")
            }
        case .c:
            switch type {
            case .flat:
                fatalError("Note does not exist")
            case .natural:
                newLetter = .b
                newType = .natural
                newOctave = NoteOctave(rawValue: octave.rawValue - 1) ?? octave
            case .sharp:
                newLetter = .c
                newType = .natural
                newOctave = octave
            }
        case .d:
            switch type {
            case .flat:
                newLetter = .c
                newType = .natural
                newOctave = octave
            case .natural:
                newLetter = .d
                newType = .flat
                newOctave = octave
            case .sharp:
                newLetter = .d
                newType = .natural
                newOctave = octave
            }
        case .e:
            switch type {
            case .flat:
                newLetter = .d
                newType = .natural
                newOctave = octave
            case .natural:
                newLetter = .e
                newType = .flat
                newOctave = octave
            case .sharp:
                fatalError("Note does not exist")
            }
        case .f:
            switch type {
            case .flat:
                fatalError("Note does not exist")
            case .natural:
                newLetter = .e
                newType = .natural
                newOctave = octave
            case .sharp:
                newLetter = .f
                newType = .natural
                newOctave = octave
            }
        case .g:
            switch type {
            case .flat:
                newLetter = .f
                newType = .natural
                newOctave = octave
            case .natural:
                newLetter = .g
                newType = .flat
                newOctave = octave
            case .sharp:
                newLetter = .g
                newType = .natural
                newOctave = octave
            }
        }
        
        return Note(letter: newLetter, type: newType, octave: newOctave, clef: clef)
    }
    
    func transpose(to transposeType: NoteType) -> Note {
        switch type {
        case .flat:
            switch transposeType {
            case .flat:
                return self
            case .natural:
                return self.transposeUpHalfStep()
            case .sharp:
                return self.transposeUpHalfStep().transposeUpHalfStep()
            }
        case .natural:
            switch transposeType {
            case .flat:
                return self.transposeDownHalfStep()
            case .natural:
                return self
            case .sharp:
                return self.transposeUpHalfStep()
            }
        case .sharp:
            switch transposeType {
            case .flat:
                return self.transposeDownHalfStep().transposeDownHalfStep()
            case .natural:
                return self.transposeDownHalfStep()
            case .sharp:
                return self
            }
        }
    }
}

extension Note: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(letter)
        hasher.combine(type)
        hasher.combine(octave)
        hasher.combine(clef)
        hasher.combine(position)
    }
}

extension Note: Comparable {
    static func < (lhs: Note, rhs: Note) -> Bool {
        if lhs.octave.octaveNumber() < rhs.octave.octaveNumber() {
            return true
        } else if lhs.octave.octaveNumber() == rhs.octave.octaveNumber() {
            if lhs.letter < rhs.letter {
                return true
            } else if lhs.letter == rhs.letter {
                if lhs.type < rhs.type {
                    return true
                } else if lhs.type == rhs.type {
                    if lhs.clef < rhs.clef {
                        return true
                    }
                }
            }
        }
        
        return false
    }
}

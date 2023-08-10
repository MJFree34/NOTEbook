//
//  Note.swift
//  ChartDomain
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matthew Free. All rights reserved.
//

import Foundation

// swiftlint:disable file_length type_body_length no_fatal_errors cyclomatic_complexity function_body_length
public struct Note: Codable, Identifiable {
    public let id = UUID()

    public let letter: NoteLetter
    public let type: NoteType
    public let octave: NoteOctave
    public let clef: Clef
    public let position: NotePosition
    public let quarterNoteType: QuarterNoteType

    public enum CodingKeys: String, CodingKey {
        case letter
        case type
        case octave
        case clef
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let letter = try container.decode(NoteLetter.self, forKey: .letter)
        let type = try container.decode(NoteType.self, forKey: .type)
        let octave = try container.decode(NoteOctave.self, forKey: .octave)
        let clef = try container.decode(Clef.self, forKey: .clef)
        self.init(letter: letter, type: type, octave: octave, clef: clef)
    }

    public init(letter: NoteLetter, type: NoteType, octave: NoteOctave, clef: Clef) {
        self.letter = letter
        self.type = type
        self.octave = octave
        self.clef = clef
        self.position = Note.calculatePosition(letter: letter, octave: octave, clef: clef)
        self.quarterNoteType = Note.calculateQuarterNoteType(from: position)
    }

    public static func middleNote(for clef: Clef) -> Note {
        switch clef {
        case .bass:
            return Note(letter: .d, type: .natural, octave: .three, clef: .bass)
        case .alto:
            return Note(letter: .c, type: .natural, octave: .four, clef: .alto)
        case .treble:
            return Note(letter: .b, type: .natural, octave: .four, clef: .treble)
        }
    }

    public static func minNote(for clef: Clef) -> Note {
        switch clef {
        case .bass:
            return Note(letter: .e, type: .natural, octave: .zero, clef: .bass)
        case .alto:
            return Note(letter: .c, type: .natural, octave: .four, clef: .alto)
        case .treble:
            return Note(letter: .c, type: .natural, octave: .two, clef: .treble)
        }
    }

    public static func maxNote(for clef: Clef) -> Note {
        switch clef {
        case .bass:
            return Note(letter: .a, type: .natural, octave: .five, clef: .bass)
        case .alto:
            return Note(letter: .c, type: .natural, octave: .four, clef: .alto)
        case .treble:
            return Note(letter: .g, type: .natural, octave: .seven, clef: .treble)
        }
    }

    public var capitalizedLetter: String {
        self.letter.rawValue.capitalized
    }

    public var positionsFromCenterStaff: Int {
        position.rawValue - NotePosition.middle3rdLine.rawValue
    }

    public var staffPosition: StaffPosition {
        if positionsFromCenterStaff > 4 {
            return .above
        } else if positionsFromCenterStaff < -4 {
            return .below
        } else {
            return .middle
        }
    }

    public var extraLines: Int {
        if staffPosition == .middle {
            return 0
        }
        return abs(positionsFromCenterStaff) / 2 - 2
    }

    public var isInSpace: Bool {
        abs(positionsFromCenterStaff).isMultiple(of: 2)
    }

    public func lowerNote() -> Note {
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

    public func higherNote() -> Note {
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

    public func transposeUpHalfStep() -> Note {
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
                fatalError("\(letter) \(type) does not exist")
            }
        case .c:
            switch type {
            case .flat:
                fatalError("\(letter) \(type) does not exist")
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
                fatalError("\(letter) \(type) does not exist")
            }
        case .f:
            switch type {
            case .flat:
                fatalError("\(letter) \(type) does not exist")
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

    public func transposeDownHalfStep() -> Note {
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

    public func transpose(to transposeType: NoteType) -> Note {
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

extension Note: Equatable {
    public static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.letter == rhs.letter && lhs.type == rhs.type && lhs.octave == rhs.octave && lhs.clef == rhs.clef
    }
}

extension Note: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(letter)
        hasher.combine(type)
        hasher.combine(octave)
        hasher.combine(clef)
        hasher.combine(position)
    }
}

extension Note: Comparable {
    public static func < (lhs: Note, rhs: Note) -> Bool {
        if lhs.octave < rhs.octave {
            return true
        } else if lhs.octave == rhs.octave {
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

extension Note {
    private static func calculateQuarterNoteType(from position: NotePosition) -> QuarterNoteType {
        if position < NotePosition.middle3rdLine {
            return .lower
        }
        return .upper
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .c:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .d:
                switch octave {
                case .zero:
                    return .bottom9thSpace
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .f:
                switch octave {
                case .zero:
                    return .bottom8thSpace
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            }
        case .alto:
            switch letter {
            case .a:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .two:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .three:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .four:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .five:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .six:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .b:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .two:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .three:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .four:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .five:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .six:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .c:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .two:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .three:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .four:
                    return .middle3rdLine
                case .five:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .six:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .d:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .two:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .three:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .four:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .five:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .six:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .e:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .two:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .three:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .four:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .five:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .six:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .f:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .two:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .three:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .four:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .five:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .six:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .g:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .two:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .three:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .four:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .five:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .six:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .seven:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            }
        case .treble:
            switch letter {
            case .a:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .b:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .eight:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .c:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .d:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .e:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .f:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            case .g:
                switch octave {
                case .zero:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                case .one:
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
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
                    fatalError("\(clef.rawValue.capitalized) \(letter.rawValue.capitalized) \(octave.rawValue) not implemented")
                }
            }
        }
    }
}

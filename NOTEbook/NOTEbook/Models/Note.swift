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

enum NotePitch: String, Decodable {
    case veryVeryHigh
    case veryLow
    case low
    case lowMedium
    case highMedium
    case high
    case veryHigh
}

enum NoteLocation {
    case bottom
    case middle
    case top
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
    
    func findLocation() -> NoteLocation {
        switch self {
        case .bottom8thLine, .bottom8thSpace, .bottom7thLine, .bottom7thSpace, .bottom6thLine, .bottom6thSpace, .bottom5thLine, .bottom5thSpace, .bottom4thLine, .bottom4thSpace, .bottom3rdLine, .bottom3rdSpace, .bottom2ndLine, .bottom2ndSpace, .bottom1stLine, .bottom1stSpace:
            return .bottom
        case .middle1stLine, .middle1stSpace, .middle2ndLine, .middle2ndSpace, .middle3rdLine, .middle3rdSpace, .middle4thLine, .middle4thSpace, .middle5thLine:
            return .middle
        default:
            return .top
        }
    }
}

struct Note: Decodable, Equatable {
    private(set) var letter: NoteLetter
    private(set) var type: NoteType
    private(set) var position: NotePosition = .middle3rdLine // Default value
    
    enum CodingKeys: String, CodingKey {
        case letter
        case type
        case pitch
        case clef
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        letter = try container.decode(NoteLetter.self, forKey: .letter)
        type = try container.decode(NoteType.self, forKey: .type)
        
        let pitch = try container.decode(NotePitch.self, forKey: .pitch)
        let clef = try container.decode(Clef.self, forKey: .clef)
        
        position = calculatePosition(from: pitch, of: clef)
    }
    
    init(letter: NoteLetter, type: NoteType, pitch: NotePitch, clef: Clef) {
        self.letter = letter
        self.type = type
        self.position = calculatePosition(from: pitch, of: clef)
    }
    
    private func calculatePosition(from pitch: NotePitch, of clef: Clef) -> NotePosition {
        switch clef {
        case .bass:
            switch pitch {
            case .veryLow:
                switch letter {
                case .a:
                    fatalError("Note not implemented")
                case .b:
                    fatalError("Note not implemented")
                case .c:
                    fatalError("Note not implemented")
                case .d:
                    fatalError("Note not implemented")
                case .e:
                    fatalError("Note not implemented")
                case .f:
                    fatalError("Note not implemented")
                case .g:
                    fatalError("Note not implemented")
                }
            case .low:
                switch letter {
                case .a:
                    return .bottom7thSpace
                case .b:
                    return .bottom6thLine
                case .c:
                    return .bottom6thSpace
                case .d:
                    return .bottom5thLine
                case .e:
                    return .bottom5thSpace
                case .f:
                    return .bottom4thLine
                case .g:
                    return .bottom4thSpace
                }
            case .lowMedium:
                switch letter {
                case .a:
                    return .bottom3rdLine
                case .b:
                    return .bottom3rdSpace
                case .c:
                    return .bottom2ndLine
                case .d:
                    return .bottom2ndSpace
                case .e:
                    return .bottom1stLine
                case .f:
                    return .bottom1stSpace
                case .g:
                    return .middle1stLine
                }
            case .highMedium:
                switch letter {
                case .a:
                    return .middle1stSpace
                case .b:
                    return .middle2ndLine
                case .c:
                    return .middle2ndSpace
                case .d:
                    return .middle3rdLine
                case .e:
                    return .middle3rdSpace
                case .f:
                    return .middle4thLine
                case .g:
                    return .middle4thSpace
                }
            case .high:
                switch letter {
                case .a:
                    return .middle5thLine
                case .b:
                    return .top1stSpace
                case .c:
                    return .top1stLine
                case .d:
                    return .top2ndSpace
                case .e:
                    return .top2ndLine
                case .f:
                    return .top3rdSpace
                case .g:
                    return .top3rdLine
                }
            case .veryHigh:
                switch letter {
                case .a:
                    return .top4thSpace
                case .b:
                    return .top4thLine
                case .c:
                    return .top5thSpace
                case .d:
                    return .top5thLine
                case .e:
                    return .top6thSpace
                case .f:
                    return .top6thLine
                case .g:
                    return .top7thSpace
                }
            case .veryVeryHigh:
                switch letter {
                case .a:
                    return .top7thLine
                case .b:
                    return .top8thSpace
                case .c:
                    fatalError("Note not implemented")
                case .d:
                    fatalError("Note not implemented")
                case .e:
                    fatalError("Note not implemented")
                case .f:
                    fatalError("Note not implemented")
                case .g:
                    fatalError("Note not implemented")
                }
            }
        case .treble:
            switch pitch {
            case .veryLow:
                switch letter {
                case .a:
                    fatalError("Note not implemented")
                case .b:
                    fatalError("Note not implemented")
                case .c:
                    return .bottom8thLine
                case .d:
                    return .bottom8thSpace
                case .e:
                    return .bottom7thLine
                case .f:
                    return .bottom7thSpace
                case .g:
                    return .bottom6thLine
                }
            case .low:
                switch letter {
                case .a:
                    return .bottom6thSpace
                case .b:
                    return .bottom5thLine
                case .c:
                    return .bottom5thSpace
                case .d:
                    return .bottom4thLine
                case .e:
                    return .bottom4thSpace
                case .f:
                    return .bottom3rdLine
                case .g:
                    return .bottom3rdSpace
                }
            case .lowMedium:
                switch letter {
                case .a:
                    return .bottom2ndLine
                case .b:
                    return .bottom2ndSpace
                case .c:
                    return .bottom1stLine
                case .d:
                    return .bottom1stSpace
                case .e:
                    return .middle1stLine
                case .f:
                    return .middle1stSpace
                case .g:
                    return .middle2ndLine
                }
            case .highMedium:
                switch letter {
                case .a:
                    return .middle2ndSpace
                case .b:
                    return .middle3rdLine
                case .c:
                    return .middle3rdSpace
                case .d:
                    return .middle4thLine
                case .e:
                    return .middle4thSpace
                case .f:
                    return .middle5thLine
                case .g:
                    return .top1stSpace
                }
            case .high:
                switch letter {
                case .a:
                    return .top1stLine
                case .b:
                    return .top2ndSpace
                case .c:
                    return .top2ndLine
                case .d:
                    return .top3rdSpace
                case .e:
                    return .top3rdLine
                case .f:
                    return .top4thSpace
                case .g:
                    return .top4thLine
                }
            case .veryHigh:
                switch letter {
                case .a:
                    return .top5thSpace
                case .b:
                    return .top5thLine
                case .c:
                    return .top6thSpace
                case .d:
                    return .top6thLine
                case .e:
                    fatalError("Note not implemented")
                case .f:
                    fatalError("Note not implemented")
                case .g:
                    fatalError("Note not implemented")
                }
            case .veryVeryHigh:
                switch letter {
                case .a:
                    fatalError("Note not implemented")
                case .b:
                    fatalError("Note not implemented")
                case .c:
                    fatalError("Note not implemented")
                case .d:
                    fatalError("Note not implemented")
                case .e:
                    fatalError("Note not implemented")
                case .f:
                    fatalError("Note not implemented")
                case .g:
                    fatalError("Note not implemented")
                }
            }
        }
    }
    
    func capitalizedLetter() -> String {
        return self.letter.rawValue.capitalized
    }
}

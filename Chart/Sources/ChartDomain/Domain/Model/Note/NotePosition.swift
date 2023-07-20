//
//  NotePosition.swift
//  NoteLibrary
//
//  Created by Matt Free on 7/11/23.
//

import Foundation

public enum NotePosition: Int {
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
}

extension NotePosition: Comparable {
    public static func < (lhs: NotePosition, rhs: NotePosition) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

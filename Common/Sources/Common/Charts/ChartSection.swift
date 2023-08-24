//
//  ChartSection.swift
//  NoteLibrary
//
//  Created by Matt Free on 7/10/23.
//

import Foundation

public enum ChartSection: String, Codable, CaseIterable {
    case woodwinds = "Woodwinds"
    case brass = "Brass"
}

extension ChartSection: Identifiable {
    public var id: String { rawValue }
}

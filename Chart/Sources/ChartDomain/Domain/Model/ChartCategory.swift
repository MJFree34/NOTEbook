//
//  ChartCategory.swift
//  ChartDomain
//
//  Created by Matt Free on 9/5/20.
//  Copyright © 2020 Matthew Free. All rights reserved.
//

import Foundation

public struct ChartCategory: Codable, Identifiable {
    private enum CodingKeys: CodingKey {
        case name
        case section
        case fingeringCharts
    }

    public var id = UUID()
    public var name: String
    public var section: ChartSection
    public var fingeringCharts: [FingeringChart]

    public init(id: UUID, name: String, section: ChartSection, fingeringCharts: [FingeringChart]) {
        self.id = id
        self.name = name
        self.section = section
        self.fingeringCharts = fingeringCharts
    }

    public init(name: String, section: ChartSection, fingeringCharts: [FingeringChart]) {
        self.init(id: UUID(), name: name, section: section, fingeringCharts: fingeringCharts)
    }
}

extension ChartCategory {
    public static let placeholder = ChartCategory(
        name: "Trumpet",
        section: .brass,
        fingeringCharts: []
    )
}

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

    public let id = UUID()
    public var name: String
    public var section: ChartSection
    public var fingeringCharts: [FingeringChart]

    public init(name: String, section: ChartSection, fingeringCharts: [FingeringChart]) {
        self.name = name
        self.section = section
        self.fingeringCharts = fingeringCharts
    }
}

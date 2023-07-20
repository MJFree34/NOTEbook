//
//  ChartSection.swift
//  ChartDomain
//
//  Created by Matt Free on 7/10/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public enum ChartSection: String, Codable, CaseIterable {
    case woodwinds = "Woodwinds"
    case brass = "Brass"
}

extension ChartSection: Identifiable {
    public var id: String { rawValue }
}

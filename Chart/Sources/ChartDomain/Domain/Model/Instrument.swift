//
//  Instrument.swift
//  ChartDomain
//
//  Created by Matt Free on 6/16/20.
//  Copyright © 2020 Matthew Free. All rights reserved.
//

import Foundation

public struct Instrument: Codable, Equatable {
    public var name: String
    public var detailName: String
    public var offset: Double

    public init(name: String, detailName: String, offset: Double) {
        self.name = name
        self.detailName = detailName
        self.offset = offset
    }
}

extension Instrument: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(detailName)
    }
}

extension Instrument {
    public static let placeholder = Instrument(
        name: "Trumpet",
        detailName: "C Trumpet",
        offset: 3
    )
}

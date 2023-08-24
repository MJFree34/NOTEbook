//
//  FingeringViewType.swift
//  ChartDomain
//
//  Created by Matt Free on 8/22/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public enum FingeringViewType: String, Codable, CaseIterable {
    case baritoneSaxophone = "Baritone Saxophone"
    case bbTriggerThreeValve = "Bb-Trigger 3-Valve"
    case clarinet = "Clarinet"
    case flute = "Flute"
    case fourValve = "4-Valve"
    case fTriggerPosition = "F-Trigger Position"
    case position = "Position"
    case saxophone = "Saxophone"
    case threeValve = "3-Valve"
}

extension FingeringViewType: Identifiable {
    public var id: String { rawValue }
}

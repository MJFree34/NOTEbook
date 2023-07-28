//
//  UserPreferences.swift
//  ChartDomain
//
//  Created by Matt Free on 7/27/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

public struct UserPreferences: Equatable {
    public var sectionsExpanded: [String : Bool]
    public var categoriesExpanded: [String : Bool]

    public init(sectionsExpanded: [String : Bool] = [:], categoriesExpanded: [String : Bool] = [:]) {
        self.sectionsExpanded = sectionsExpanded
        self.categoriesExpanded = categoriesExpanded
    }
}

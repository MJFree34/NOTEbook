//
//  SaveUserPreferencesUseCase.swift
//  ChartDomain
//
//  Created by Matt Free on 7/27/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine
import Common

public final class SaveUserPreferencesUseCase {
    @DependencyInjected(ChartRepositoryProtocol.self) private var repository

    init() { }

    public func execute(userPreferences: UserPreferences) throws {
        try repository.saveUserPreferences(userPreferences: userPreferences)
    }
}

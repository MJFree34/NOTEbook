//
//  FetchUserPreferencesUseCase.swift
//  ChartDomain
//
//  Created by Matt Free on 7/27/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine
import Common

public final class FetchUserPreferencesUseCase {
    @DependencyInjected(ChartRepositoryProtocol.self) private var repository

    init() { }

    public func execute(chartsFilename: String) -> AnyPublisher<UserPreferences, ChartError> {
        repository.fetchUserPreferences(chartsFilename: chartsFilename)
    }
}

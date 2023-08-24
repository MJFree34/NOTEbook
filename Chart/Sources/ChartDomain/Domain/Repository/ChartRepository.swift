//
//  ChartRepository.swift
//  ChartDomain
//
//  Created by Matt Free on 7/16/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine
import Common
import Storage

// swiftlint:disable trailing_closure
final class ChartRepository: ChartRepositoryProtocol {
    @DependencyInjected(ChartLocalDataSourceProtocol.self) private var localDataSource
    @DependencyInjected(ChartRemoteDataSourceProtocol.self) private var remoteDataSource
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage

    func fetchCharts(networkURLString: String, chartsFilename: String) -> AnyPublisher<ChartCategories, ChartError> {
        remoteDataSource.fetchCharts(networkURLString: networkURLString, chartsFilename: chartsFilename)
            .catch { _ in
                self.keyValueStorage.set(false, for: .chartsUpdatedFromNetwork)
                return self.localDataSource.fetchCharts(chartsFilename: chartsFilename)
            }
            .handleEvents(
                receiveOutput: { chartCategories in
                    try? self.saveCharts(chartsFilename: chartsFilename, chartCategories: chartCategories)
                }
            )
            .eraseToAnyPublisher()
    }

    func fetchHelperCharts(chartsFilename: String) -> AnyPublisher<ChartCategories, ChartError> {
        localDataSource.fetchCharts(chartsFilename: chartsFilename)
            .handleEvents(
                receiveOutput: { chartCategories in
                    try? self.saveCharts(chartsFilename: chartsFilename, chartCategories: chartCategories)
                }
            )
            .eraseToAnyPublisher()
    }

    func fetchUserPreferences(chartsFilename: String) -> AnyPublisher<UserPreferences, ChartError> {
        localDataSource.fetchUserPreferences(chartsFilename: chartsFilename)
            .handleEvents(
                receiveOutput: { userPreferences in
                    try? self.saveUserPreferences(userPreferences: userPreferences)
                }
            )
            .eraseToAnyPublisher()
    }

    func saveCharts(chartsFilename: String, chartCategories: ChartCategories) throws {
        try localDataSource.saveCharts(chartsFilename: chartsFilename, chartCategories: chartCategories)
    }

    func saveUserPreferences(userPreferences: UserPreferences) throws {
        try localDataSource.saveUserPreferences(userPreferences: userPreferences)
    }
}

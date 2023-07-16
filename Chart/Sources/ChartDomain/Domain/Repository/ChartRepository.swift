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

final class ChartRepository: ChartRepositoryProtocol {
    @DependencyInjected(ChartLocalDataSourceProtocol.self) private var localDataSource
    @DependencyInjected(ChartRemoteDataSourceProtocol.self) private var remoteDataSource
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage

    func fetchCharts(networkURLString: String, chartsFilename: String) -> AnyPublisher<[ChartCategory], ChartError> {
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

    func saveCharts(chartsFilename: String, chartCategories: [ChartCategory]) throws {
        try localDataSource.saveCharts(chartsFilename: chartsFilename, chartCategories: chartCategories)
    }
}

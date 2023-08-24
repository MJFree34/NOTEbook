//
//  ChartRemoteDataSource.swift
//  ChartDomain
//
//  Created by Matt Free on 7/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine
import Common
import Foundation
import Storage

final class ChartRemoteDataSource: ChartRemoteDataSourceProtocol {
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage

    func fetchCharts(networkURLString: String, chartsFilename: String) -> AnyPublisher<ChartCategories, ChartError> {
        guard let networkChartsURL = URL(string: networkURLString)?.appendingPathComponent("\(chartsFilename).json") else {
            return Fail(error: ChartError.invalidNetworkURL)
                .eraseToAnyPublisher()
        }

        keyValueStorage.set(true, for: .chartsUpdatedFromNetwork)

        return URLSession.shared
            .dataTaskPublisher(for: networkChartsURL)
            .retry(3)
            .mapError { _ in
                ChartError.networkError
            }
            .map(\.data)
            .decode(type: ChartCategories.self, decoder: JSONDecoder())
            .mapError { error -> ChartError in
                if let error = error as? ChartError {
                    return error
                }
                return ChartError.decodingError
            }
            .eraseToAnyPublisher()
    }
}

//
//  FetchChartsUseCase.swift
//  ChartDomain
//
//  Created by Matt Free on 7/16/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine
import Common

public final class FetchChartsUseCase {
    @DependencyInjected(ChartRepositoryProtocol.self) private var repository

    init() { }

    public func execute(networkURLString: String, chartsFilename: String) -> AnyPublisher<[ChartCategory], ChartError> {
        return repository.fetchCharts(networkURLString: networkURLString, chartsFilename: chartsFilename)
    }
}

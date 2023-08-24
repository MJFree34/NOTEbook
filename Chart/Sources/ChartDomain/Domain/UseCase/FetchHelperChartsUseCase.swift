//
//  FetchHelperChartsUseCase.swift
//  ChartDomain
//
//  Created by Matt Free on 7/25/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine
import Common

public final class FetchHelperChartsUseCase {
    @DependencyInjected(ChartRepositoryProtocol.self) private var repository

    init() { }

    public func execute(chartsFilename: String) -> AnyPublisher<ChartCategories, ChartError> {
        repository.fetchHelperCharts(chartsFilename: chartsFilename)
    }
}

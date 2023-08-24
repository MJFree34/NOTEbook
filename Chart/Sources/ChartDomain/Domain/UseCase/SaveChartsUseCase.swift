//
//  SaveChartsUseCase.swift
//  ChartDomain
//
//  Created by Matt Free on 7/16/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine
import Common

public final class SaveChartsUseCase {
    @DependencyInjected(ChartRepositoryProtocol.self) private var repository

    init() { }

    public func execute(chartsFilename: String, chartCategories: [ChartCategory]) throws {
        try repository.saveCharts(chartsFilename: chartsFilename, chartCategories: chartCategories)
    }
}

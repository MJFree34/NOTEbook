//
//  ChartRepositoryProtocol.swift
//  ChartDomain
//
//  Created by Matt Free on 7/16/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine

public protocol ChartRepositoryProtocol {
    func fetchCharts(networkURLString: String, chartsFilename: String) -> AnyPublisher<ChartCategories, ChartError>
    func fetchHelperCharts(chartsFilename: String) -> AnyPublisher<ChartCategories, ChartError>
    func saveCharts(chartsFilename: String, chartCategories: ChartCategories) throws
}

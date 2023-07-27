//
//  ChartLocalDataSourceProtocol.swift
//  ChartDomain
//
//  Created by Matt Free on 7/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine

protocol ChartLocalDataSourceProtocol {
    func fetchCharts(chartsFilename: String) -> AnyPublisher<ChartCategories, ChartError>
    func saveCharts(chartsFilename: String, chartCategories: ChartCategories) throws
}

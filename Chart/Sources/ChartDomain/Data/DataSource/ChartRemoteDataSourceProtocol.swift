//
//  ChartRemoteDataSourceProtocol.swift
//  ChartDomain
//
//  Created by Matt Free on 7/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine

protocol ChartRemoteDataSourceProtocol {
    func fetchCharts(networkURLString: String, chartsFilename: String) -> AnyPublisher<[ChartCategory], ChartError>
}

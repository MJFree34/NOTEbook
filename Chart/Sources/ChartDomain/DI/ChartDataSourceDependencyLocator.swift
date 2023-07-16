//
//  ChartDataSourceDependencyLocator.swift
//  ChartDomain
//
//  Created by Matt Free on 7/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Common

class ChartDataSourceDependencyLocator: ModuleDependencyLocator {
    static func addDependenciesToContainer(container: DependencyLocatorProtocol) {
        container.register(type: ChartLocalDataSourceProtocol.self, component: ChartLocalDataSource())
        container.register(type: ChartRemoteDataSourceProtocol.self, component: ChartRemoteDataSource())
    }
}

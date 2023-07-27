//
//  ChartUseCaseDependencyLocator.swift
//  ChartDomain
//
//  Created by Matt Free on 7/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Common

final class ChartUseCaseDependencyLocator: ModuleDependencyLocator {
    static func addDependenciesToContainer(container: DependencyLocatorProtocol) {
        container.register(type: FetchChartsUseCase.self, component: FetchChartsUseCase())
        container.register(type: FetchHelperChartsUseCase.self, component: FetchHelperChartsUseCase())
        container.register(type: SaveChartsUseCase.self, component: SaveChartsUseCase())
    }
}

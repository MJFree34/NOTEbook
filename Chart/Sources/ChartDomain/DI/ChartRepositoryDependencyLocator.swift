//
//  ChartRepositoryDependencyLocator.swift
//  ChartDomain
//
//  Created by Matt Free on 7/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Common

final class ChartRepositoryDependencyLocator: ModuleDependencyLocator {
    static func addDependenciesToContainer(container: DependencyLocatorProtocol) {
        container.register(type: ChartRepositoryProtocol.self, component: ChartRepository())
    }
}

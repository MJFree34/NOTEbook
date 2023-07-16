//
//  ChartDependencyLocator.swift
//  ChartDomain
//
//  Created by Matt Free on 7/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Common

public class ChartDependencyLocator: ModuleDependencyLocator {
    public static func addDependenciesToContainer(container: DependencyLocatorProtocol) {
        ChartDataSourceDependencyLocator.addDependenciesToContainer(container: container)
        ChartRepositoryDependencyLocator.addDependenciesToContainer(container: container)
        ChartUseCaseDependencyLocator.addDependenciesToContainer(container: container)
    }
}

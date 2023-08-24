//
//  ChartDependencyLocator.swift
//  ChartDomain
//
//  Created by Matt Free on 7/15/23.
//

import Common

public class ChartDependencyLocator: ModuleDependencyLocator {
    public static func addDependenciesToContainer(container: DependencyLocator) {
        ChartDataSourceDependencyLocator.addDependenciesToContainer(container: container)
        ChartRepositoryDependencyLocator.addDependenciesToContainer(container: container)
        ChartUseCaseDependencyLocator.addDependenciesToContainer(container: container)
    }
}

//
//  DependencyLocatorModuleProtocol.swift
//  Common
//
//  Created by Matt Free on 7/15/23.
//

public protocol ModuleDependencyLocator {
    static func addDependenciesToContainer(container: DependencyLocator)
}

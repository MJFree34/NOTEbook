//
//  DependencyLocatorModuleProtocol.swift
//  Common
//
//  Created by Matt Free on 7/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

public protocol ModuleDependencyLocator {
    static func addDependenciesToContainer(container: DependencyLocatorProtocol)
}

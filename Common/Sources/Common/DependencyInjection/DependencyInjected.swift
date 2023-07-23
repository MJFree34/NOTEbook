//
//  DependencyInjected.swift
//  Common
//
//  Created by Matt Free on 7/10/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

@propertyWrapper
public struct DependencyInjected<T> {
    private let dependencyType: T.Type

    public var wrappedValue: T {
        guard let dependency = DependencyLocator.shared.resolve(type: dependencyType) else {
            // swiftlint:disable:next no_fatal_errors
            fatalError("Could not resolve dependency of \(dependencyType)")
        }

        return dependency
    }

    public init(_ dependencyType: T.Type) {
        self.dependencyType = dependencyType
    }
}
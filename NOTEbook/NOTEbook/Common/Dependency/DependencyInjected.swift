//
//  DependencyInjected.swift
//  NOTEbook
//
//  Created by Matt Free on 7/10/23.
//

import Foundation

// swiftlint:disable no_fatal_errors
@propertyWrapper
struct DependencyInjected<T> {
    private let dependencyType: T.Type

    var wrappedValue: T {
        guard let dependency = DependencyLocator.shared.resolve(type: dependencyType) else {
            fatalError("Could not resolve dependency of \(dependencyType)")
        }
        return dependency
    }

    init(_ dependencyType: T.Type) {
        self.dependencyType = dependencyType
    }
}
// swiftlint:enable no_fatal_errors

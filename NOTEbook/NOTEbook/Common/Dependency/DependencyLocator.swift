//
//  DependencyLocator.swift
//  NOTEbook
//
//  Created by Matt Free on 7/10/23.
//

import Foundation

final class DependencyLocator {
    static let shared = DependencyLocator()

    private var components: [String: Any] = [:]

    private init() { }

    func register<Component>(type: Component.Type, component: Any) {
        components["\(type)"] = component
    }

    func resolve<Component>(type: Component.Type) -> Component? {
        components["\(type)"] as? Component
    }
}

//
//  DependencyLocator.swift
//  Common
//
//  Created by Matt Free on 7/10/23.
//

public final class DependencyLocator {
    public static let shared = DependencyLocator()

    private var components: [String: Any] = [:]

    private init() { }

    public func register<Component>(type: Component.Type, component: Any) {
        components["\(type)"] = component
    }

    public func resolve<Component>(type: Component.Type) -> Component? {
        components["\(type)"] as? Component
    }
}

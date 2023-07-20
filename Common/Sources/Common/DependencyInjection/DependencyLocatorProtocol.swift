//
//  DependencyLocatorProtocol.swift
//  Common
//
//  Created by Matt Free on 7/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

public protocol DependencyLocatorProtocol {
    func register<Component>(type: Component.Type, component: Any)
    func resolve<Component>(type: Component.Type) -> Component?
}

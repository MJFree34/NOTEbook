//
//  ActionableView.swift
//  CommonUI
//
//  Created by Matt Free on 7/22/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public protocol ActionableView {
    typealias ActionClosure = ((Action) -> Void)?

    associatedtype Action

    var onAction: ActionClosure { get set }
}

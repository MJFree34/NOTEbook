//
//  ActionableView.swift
//  CommonUI
//
//  Created by Matt Free on 7/28/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public protocol ActionableView {
    associatedtype Action

    typealias ActionClosure = ((Action) -> Void)?

    var onAction: ActionClosure { get set }
}

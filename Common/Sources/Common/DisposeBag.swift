//
//  DisposeBag.swift
//  Common
//
//  Created by Matt Free on 7/9/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine

public typealias DisposeBag = Set<AnyCancellable>

extension DisposeBag {
    mutating func dispose() {
        removeAll()
    }
}

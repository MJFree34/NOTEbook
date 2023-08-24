//
//  DisposeBag.swift
//  NOTEbook
//
//  Created by Matt Free on 7/9/23.
//

import Combine

typealias DisposeBag = Set<AnyCancellable>

extension DisposeBag {
    mutating func dispose() {
        removeAll()
    }
}

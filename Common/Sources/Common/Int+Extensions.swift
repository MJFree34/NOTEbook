//
//  Int+Extensions.swift
//  Common
//
//  Created by Matt Free on 8/9/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

extension Int {
    public func isEven() -> Bool {
        self.isMultiple(of: 2)
    }

    public func isOdd() -> Bool {
        !isEven()
    }
}

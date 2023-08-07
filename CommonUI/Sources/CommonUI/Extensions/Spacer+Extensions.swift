//
//  Spacer+Extensions.swift
//  CommonUI
//
//  Created by Matt Free on 8/6/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

extension Spacer {
    public init(minLength: Spacing) {
        self.init(minLength: minLength.rawValue)
    }
}

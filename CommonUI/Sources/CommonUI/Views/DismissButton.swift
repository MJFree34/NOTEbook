//
//  DismissButton.swift
//  CommonUI
//
//  Created by Matt Free on 7/30/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public struct DismissButton: View {
    private let dismissAction: DismissAction

    public init(dismissAction: DismissAction) {
        self.dismissAction = dismissAction
    }

    public var body: some View {
        Button("Close") {
            dismissAction()
        }
    }
}

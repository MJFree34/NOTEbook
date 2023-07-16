//
//  NOTEbookApp.swift
//  NOTEbook
//
//  Created by Matt Free on 6/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import Common
import Storage
import SwiftUI

@main
struct NOTEbookApp: App {
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage

    var body: some Scene {
        WindowGroup {
            NotePickerView(viewModel: ChartsViewModel())
        }
    }

    init() {
        setupDependencies()
        setupKeyValueStorage()
    }

    func setupDependencies() {
        DependencyLocator.shared.register(type: KeyValueStorage.self, component: UserDefaultsKeyValueStorage())

        ChartDependencyLocator.addDependenciesToContainer(container: DependencyLocator.shared)
    }

    func setupKeyValueStorage() {
        keyValueStorage.register(
            defaults: [
                .chartsCacheCreated: false,
                .chartsUpdatedFromNetwork: false
            ]
        )
    }
}

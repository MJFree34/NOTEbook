//
//  NOTEbookHelperApp.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/21/22.
//  Copyright © 2022 Matthew Free. All rights reserved.
//

import ChartDomain
import Common
import Storage
import SwiftUI

@main
struct NOTEbookHelperApp: App {
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage

    var body: some Scene {
        WindowGroup {
            CategoriesListView()
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
                .chartsUpdatedFromNetwork: false,
                .userCategoriesExpanded: Data(),
                .userSectionsExpanded: Data()
            ]
        )
    }
}

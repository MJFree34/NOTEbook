//
//  NOTEbookApp.swift
//  NOTEbook
//
//  Created by Matt Free on 6/15/23.
//

import ChartDomain
import Common
import SwiftUI

@main
struct NOTEbookApp: App {
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage

    var body: some Scene {
        WindowGroup {
            NotePickerView()
        }
    }

    init() {
        DependencyLocator.shared.register(type: KeyValueStorage.self, component: UserDefaultsKeyValueStorage())

        ChartDependencyLocator.addDependenciesToContainer(container: DependencyLocator.shared)

        keyValueStorage.register(
            defaults: [
                .chartsCacheCreated: false,
                .chartsUpdatedFromNetwork: false
            ]
        )
    }
}

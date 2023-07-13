//
//  NOTEbookApp.swift
//  NOTEbook
//
//  Created by Matt Free on 6/15/23.
//

import SwiftUI

@main
struct NOTEbookApp: App {
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage

    @StateObject private var chartsViewModel: ChartsViewModel

    var body: some Scene {
        WindowGroup {
            NotePickerView()
        }
    }

    init() {
        DependencyLocator.shared.register(type: KeyValueStorage.self, component: UserDefaultsKeyValueStorage())
        DependencyLocator.shared.register(type: ChartsRepository.self, component: ChartsRepository())

        self._chartsViewModel = StateObject(wrappedValue: ChartsViewModel())

        keyValueStorage.register(defaults: [
            .chartsCacheCreated: false,
            .chartsUpdatedFromNetwork: false
        ])
    }
}

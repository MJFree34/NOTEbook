//
//  NOTEbookHelperApp.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/21/22.
//  Copyright © 2022 Matthew Free. All rights reserved.
//

import SwiftUI

@main
struct NOTEbookHelperApp: App {
    @StateObject private var helperChartsController: HelperChartsController

    init() {
        UserDefaults.standard.register(defaults: [
            "ChartsCacheCreated": false
        ])

        _helperChartsController = StateObject(wrappedValue: HelperChartsController.shared)
    }

    var body: some Scene {
        WindowGroup {
            InstrumentsListView()
                .environmentObject(helperChartsController)
        }
    }
}

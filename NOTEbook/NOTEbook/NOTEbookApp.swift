//
//  NOTEbookApp.swift
//  NOTEbook
//
//  Created by Matt Free on 6/15/23.
//

import SwiftUI

@main
struct NOTEbookApp: App {
    @StateObject private var chartsController: ChartsController
    
    init() {
        UserDefaults.standard.register(defaults: [
            UserDefaults.Keys.chartsCacheCreated.rawValue: false
        ])
        
        self._chartsController = StateObject(wrappedValue: ChartsController.shared)
    }
    
    var body: some Scene {
        WindowGroup {
            NotePickerView()
                .environmentObject(chartsController)
        }
    }
}

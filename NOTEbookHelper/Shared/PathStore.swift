//
//  PathStore.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 12/29/22.
//

import SwiftUI

class PathStore: ObservableObject {
    @Published var path = NavigationPath() {
        didSet {
            saveNavigationPath()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedNavigationPathStore")
    
    init() {
        if let pathData = try? Data(contentsOf: savePath) {
            if let pathDecoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: pathData) {
                path = NavigationPath(pathDecoded)
            }
        }
    }
    
    private func saveNavigationPath() {
        guard let codableRepresentation = path.codable else { return }
        
        do {
            let pathData = try JSONEncoder().encode(codableRepresentation)
            try pathData.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

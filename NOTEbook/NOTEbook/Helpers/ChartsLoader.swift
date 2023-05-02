//
//  ChartsLoader.swift
//  NOTEbook
//
//  Created by Matt Free on 6/18/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Foundation

enum ChartLoadingError: Error {
    case invalidURL
    case unloadableData
    case decodingError
}

struct ChartsLoader {
    static func loadCharts() throws -> [ChartCategory] {
        guard let chartsURL = Bundle.main.url(forResource: "ChartsRevised", withExtension: "json") else { throw ChartLoadingError.invalidURL }
        guard let data = try? Data(contentsOf: chartsURL) else { throw ChartLoadingError.unloadableData }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode([ChartCategory].self, from: data)
        } catch {
            throw ChartLoadingError.decodingError
        }
    }
}

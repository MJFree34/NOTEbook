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
    case unencodableData
    case decodingError
    case writingError
}

struct ChartsLoader {
    static let chartsFilename = "Charts"
    
    static func loadCharts() throws -> [ChartCategory] {
        let chartsURLOptional: URL?
        let chartsCacheCreated = UserDefaults.standard.bool(forKey: "ChartsCacheCreated")
        
        if chartsCacheCreated {
            chartsURLOptional = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(chartsFilename).json")
        } else {
            chartsURLOptional = Bundle.main.url(forResource: chartsFilename, withExtension: "json")
        }
        
        guard chartsURLOptional != nil, let chartsURL = chartsURLOptional else { throw ChartLoadingError.invalidURL }
        
        guard let data = try? Data(contentsOf: chartsURL) else { throw ChartLoadingError.unloadableData }
        
        let decoder = JSONDecoder()
        
        do {
            let chartCategories = try decoder.decode([ChartCategory].self, from: data)
            if !chartsCacheCreated {
                try saveCharts(chartCategories: chartCategories)
                UserDefaults.standard.set(true, forKey: "ChartsCacheCreated")
            }
            return chartCategories
        } catch {
            throw ChartLoadingError.decodingError
        }
    }
    
    static func saveCharts(chartCategories: [ChartCategory]) throws {
        let chartsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(chartsFilename).json")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let data = try? encoder.encode(chartCategories) else { throw ChartLoadingError.unencodableData }
        
        do {
            try data.write(to: chartsURL)
        } catch {
            print(error.localizedDescription)
            throw ChartLoadingError.writingError
        }
    }
}

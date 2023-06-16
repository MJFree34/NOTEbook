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
    static let chartsFilename = "Charts-v2.0"
    
    static func loadCharts() async throws -> [ChartCategory] {
        let chartsCacheCreated = UserDefaults.standard.bool(forKey: UserDefaults.Keys.chartsCacheCreated.rawValue)
        let data: Data
        
        if let networkData = await networkChartsData() {
            data = networkData
        } else {
            data = chartsCacheCreated ? try savedChartsData() : try bundleChartsData()
        }
        
        let decoder = JSONDecoder()
        
        do {
            let chartCategories = try decoder.decode([ChartCategory].self, from: data)
            if !chartsCacheCreated {
                try saveCharts(chartCategories: chartCategories)
                UserDefaults.standard.set(true, forKey: UserDefaults.Keys.chartsCacheCreated.rawValue)
            }
            return chartCategories
        } catch {
            throw ChartLoadingError.decodingError
        }
    }
    
    private static func networkChartsData() async -> Data? {
        guard let networkChartsURL = Constants.networkChartsURL?.appendingPathComponent("\(chartsFilename).json") else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: networkChartsURL)
            return data
        } catch {
            return nil
        }
    }
    
    private static func bundleChartsData() throws -> Data {
        let bundleChartsURL = Bundle.main.url(forResource: chartsFilename, withExtension: "json")
        
        guard let bundleChartsURL = bundleChartsURL else { throw ChartLoadingError.invalidURL }
        
        guard let data = try? Data(contentsOf: bundleChartsURL) else { throw ChartLoadingError.unloadableData }
        
        return data
    }
    
    private static func savedChartsData() throws -> Data {
        let savedChartsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(chartsFilename).json")
        
        guard let data = try? Data(contentsOf: savedChartsURL) else { throw ChartLoadingError.unloadableData }
        
        return data
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

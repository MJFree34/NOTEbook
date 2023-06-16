//
//  ChartsController.swift
//  NOTEbook
//
//  Created by Matt Free on 6/15/23.
//

import SwiftUI

@MainActor
class ChartsController: ObservableObject {
    static let shared = ChartsController()
    
    @Published private(set) var chartCategories = [ChartCategory]()
    
    // MARK: - Init
    
    private init() {
        Task {
            do {
                self.chartCategories = try await ChartsLoader.loadCharts()
            } catch ChartLoadingError.invalidURL {
                fatalError("Invalid URL")
            } catch ChartLoadingError.unloadableData {
                fatalError("Data is unloadable")
            } catch ChartLoadingError.decodingError {
                fatalError("Decoding error")
            } catch {
                fatalError("Fail to load charts")
            }
        }
    }
    
    // MARK: - Saving
    
    private func save() {
        do {
            try ChartsLoader.saveCharts(chartCategories: chartCategories)
        } catch ChartLoadingError.invalidURL {
            fatalError("Invalid URL")
        } catch ChartLoadingError.unencodableData {
            fatalError("Data is unencodable")
        } catch ChartLoadingError.writingError {
            fatalError("Chart writing error")
        } catch {
            fatalError("Fail to load charts")
        }
    }
    
    // MARK: - Getters
    
    private func chartCategory(ofType type: ChartCategoryType) -> ChartCategory? {
        return chartCategories.first { $0.type == type }
    }
    
    // MARK: - Preview Data
    
    #if(DEBUG)
    
    static var exampleChartCategory = shared.chartCategory(ofType: .trumpet)!
    static var exampleChart = exampleChartCategory.fingeringCharts.first!
    
    #endif
}

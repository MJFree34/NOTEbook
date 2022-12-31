//
//  HelperChartsController.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/24/22.
//

import Foundation

class HelperChartsController: ObservableObject {
    static let shared = HelperChartsController()
    
    var currentChart: FingeringChart!
    var currentChartCategory: ChartCategory!
    
    @Published private(set) var chartCategories = [ChartCategory]()
    
    init() {
        do {
            chartCategories = try ChartsLoader.loadCharts()
        } catch ChartLoadingError.invalidURL {
            fatalError("Invalid URL")
        } catch ChartLoadingError.unloadableData {
            fatalError("Data is unloadable")
        } catch ChartLoadingError.decodingError {
            fatalError("Decoding error")
        } catch {
            fatalError("Fail to load charts")
        }
        
        currentChartCategory = chartCategory(with: "Trumpet")
        currentChart = currentChartCategory.fingeringCharts[0]
    }
}

extension HelperChartsController {
    func chartCategories(in section: ChartSection) -> [ChartCategory] {
        chartCategories.filter { $0.section == section }
    }
    
    private func chartCategory(with categoryName: String) -> ChartCategory? {
        return chartCategories.first { $0.name == categoryName }
    }
    
    func moveFingeringChartInChartCategory(categoryName: String, fromOffsets: IndexSet, toOffset: Int) {
        let index = chartCategories.firstIndex { $0.name == categoryName }
        
        if let index = index {
            chartCategories[index].fingeringCharts.move(fromOffsets: fromOffsets, toOffset: toOffset)
        }
    }
    
    func moveChartCategory(fromOffsets: IndexSet, toOffset: Int) {
        chartCategories.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
}

extension HelperChartsController {
    static var exampleChart = shared.chartCategories[0].fingeringCharts[0]
}

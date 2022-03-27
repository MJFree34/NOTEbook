//
//  HelperChartsController.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/24/22.
//

import Foundation

class HelperChartsController: ObservableObject {
    static let shared = HelperChartsController()
    
    private(set) var chartCategories = [ChartCategory]()
    
    var currentChart: FingeringChart!
    var currentChartCategory: ChartCategory!
    
    init() {
        do {
            chartCategories = try ChartsLoader.loadCharts()
        } catch {
            fatalError("Fail to load charts")
        }
        
        currentChartCategory = chartCategory(with: "Trumpet")
        currentChart = currentChartCategory.fingeringCharts[0]
    }
}

extension HelperChartsController {
    var numberOfNoteFingeringsInCurrentChart: Int {
        return currentChart.noteFingerings.count
    }
    
    var numberOfCategories: Int {
        return chartCategories.count
    }
    
    var currentCategoryInstrumentsCount: Int {
        return currentChartCategory.fingeringCharts.count
    }
    
    func changeCurrentChart(to categoryName: String, chartIndex: Int) {
        currentChartCategory = chartCategory(with: categoryName)!
        currentChart = currentChartCategory.fingeringCharts[chartIndex]
    }
    
    func noteFingeringInCurrentChart(for note: Note) -> NoteFingering? {
        for noteFingering in currentChart.noteFingerings {
            if noteFingering.notes.contains(note) {
                return noteFingering
            }
        }
        
        return nil
    }
    
    func currentFingering(note: Note) -> NoteFingering? {
        for fingering in currentChart.noteFingerings {
            for fingeringNote in fingering.notes {
                if fingeringNote == note {
                    return fingering
                }
            }
        }
        
        return nil
    }
    
    func currentNote(from noteType: NoteType, index: Int) -> Note {
        switch noteType {
        case .natural:
            return currentChart.naturalNotes[index]
        case .sharp:
            if index == currentChart.sharpNotes.count {
                return currentChart.sharpNotes[currentChart.sharpNotes.count - 1]
            }
            return currentChart.sharpNotes[index]
        case .flat:
            return currentChart.flatNotes[index]
        }
    }
    
    private func chartCategory(with categoryName: String) -> ChartCategory? {
        for category in chartCategories {
            if category.name == categoryName {
                return category
            }
        }
        
        return nil
    }
}

#if DEBUG
extension HelperChartsController {
    static var exampleChart = shared.chartCategories[0].fingeringCharts[0]
}
#endif

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
    private func chartCategory(with categoryName: String) -> ChartCategory? {
        return chartCategories.first { $0.name == categoryName }
    }
    
    private func chartCategoryIndex(with categoryName: String) -> Int? {
        return chartCategories.firstIndex { $0.name == categoryName }
    }
    
    func chartCategories(in section: ChartSection) -> [ChartCategory] {
        chartCategories.filter { $0.section == section }
    }
    
    func moveFingeringChartInChartCategory(categoryName: String, fromOffsets: IndexSet, toOffset: Int) {
        if let index = chartCategoryIndex(with: categoryName) {
            chartCategories[index].fingeringCharts.move(fromOffsets: fromOffsets, toOffset: toOffset)
        }
    }
    
    func moveChartCategory(fromOffsets: IndexSet, toOffset: Int) {
        chartCategories.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func addChartCategory(category: ChartCategory) {
        let categorySection = category.section
        
        var indexToInsertAt: Int?
        
        let lastIndexOfSection = chartCategories.lastIndex { categorySection == $0.section }
        
        if let lastIndexOfSection = lastIndexOfSection {
            indexToInsertAt = lastIndexOfSection + 1
        } else if categorySection == ChartSection.allCases[0] {
            indexToInsertAt = 0
        } else {
            for (index, section) in ChartSection.allCases.enumerated() {
                if section == categorySection {
                    if index == ChartSection.allCases.count - 1 {
                        indexToInsertAt = chartCategories.count
                    } else {
                        indexToInsertAt = chartCategories.lastIndex { ChartSection.allCases[index - 1] == $0.section } ?? 0 + 1
                    }
                }
            }
        }
        
        if let indexToInsertAt = indexToInsertAt {
            chartCategories.insert(category, at: indexToInsertAt)
        } else {
            print("Chart Category is not able to be added as it is an edge case")
        }
    }
    
    func addChart(in categoryName: String, chart: FingeringChart) {
        if let index = chartCategoryIndex(with: categoryName) {
            chartCategories[index].fingeringCharts.append(chart)
        }
    }
    
    func generateNoteList(minNote: Note, maxNote: Note, listNoteType: NoteType) -> [Note] {
        var list = [minNote.transpose(to: listNoteType)]
        var currentNote = minNote
        
        while currentNote != maxNote {
            currentNote = currentNote.higherNote()
            list.append(currentNote.transpose(to: listNoteType))
        }
        
        return list
    }
    
    func generateEmptyNoteFingerings(naturalNotes: [Note], flatNotes: [Note], sharpNotes: [Note]) -> [NoteFingering] {
        var noteFingerings = [NoteFingering]()
        
        var index = 0
        
        if flatNotes[index].type == .flat {
            let flatNote = flatNotes[index]
            let sharpNote = flatNote.transposeDownHalfStep().transposeUpHalfStep()
            noteFingerings.append(NoteFingering(notes: [sharpNote, flatNote], fingerings: []))
        } else {
            noteFingerings.append(NoteFingering(notes: [flatNotes[index]], fingerings: []))
        }
        
        noteFingerings.append(NoteFingering(notes: [naturalNotes[index]], fingerings: []))
        
        if sharpNotes[index].type == .sharp {
            let flatNote = flatNotes[index + 1]
            let sharpNote = sharpNotes[index]
            noteFingerings.append(NoteFingering(notes: [sharpNote, flatNote], fingerings: []))
        }
        
        index += 1
        
        while index < naturalNotes.count {
            noteFingerings.append(NoteFingering(notes: [naturalNotes[index]], fingerings: []))
            
            if sharpNotes[index].type == .sharp {
                let flatNote: Note
                
                if index == naturalNotes.count - 1 {
                    flatNote = sharpNotes[index].transposeUpHalfStep().transposeDownHalfStep()
                } else {
                    flatNote = flatNotes[index + 1]
                }
                
                let sharpNote = sharpNotes[index]
                noteFingerings.append(NoteFingering(notes: [sharpNote, flatNote], fingerings: []))
            }
            
            index += 1
        }
        
        return noteFingerings
    }
}

extension HelperChartsController {
    static var exampleChartCategory = shared.chartCategories[0]
    static var exampleChart = exampleChartCategory.fingeringCharts[0]
}

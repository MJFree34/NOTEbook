//
//  HelperChartsController.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/24/22.
//

import Foundation
import SwiftUI

class HelperChartsController: ObservableObject {
    static let shared = HelperChartsController()
    
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
    }
}

extension HelperChartsController {
    private func chartCategory(with categoryName: String) -> ChartCategory? {
        return chartCategories.first { $0.name == categoryName }
    }
    
    private func chartCategoryIndex(with categoryName: String) -> Int? {
        return chartCategories.firstIndex { $0.name == categoryName }
    }
    
    private func fingeringChartIndex(in category: ChartCategory, instrumentType: InstrumentType) -> Int? {
        return category.fingeringCharts.firstIndex { $0.instrument.type == instrumentType }
    }
    
    private func noteFingeringIndex(in chart: FingeringChart, firstNote: Note) -> Int? {
        return chart.noteFingerings.firstIndex { $0.notes[0] == firstNote }
    }
    
    func chart(in categoryName: String, instrumentType: InstrumentType) -> FingeringChart? {
        return chartCategory(with: categoryName)?.fingeringCharts.first { $0.instrument.type == instrumentType }
    }
    
    func bindingToCategoryName(categoryName: String) -> Binding<String>? {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName) {
            return Binding {
                self.chartCategories[chartCategoryIndex].name
            } set: { newName in
                self.chartCategories[chartCategoryIndex].name = newName
            }
        }
        return nil
    }
    
    func bindingToFingeringChart(in categoryName: String, instrumentType: InstrumentType) -> Binding<FingeringChart>? {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: instrumentType) {
            return Binding {
                self.chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex]
            } set: { newFingeringChart in
                self.chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex] = newFingeringChart
            }
        }
        return nil
    }
    
    func bindingToNoteFingering(in categoryName: String, instrumentType: InstrumentType, firstNote: Note) -> Binding<NoteFingering>? {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: instrumentType), let noteFingeringIndex = noteFingeringIndex(in: chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex], firstNote: firstNote) {
            return Binding {
                self.chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex]
            } set: { newNoteFingering in
                self.chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex] = newNoteFingering
            }
        }
        return nil
    }
    
    func chartCategories(in section: ChartSection) -> [ChartCategory] {
        chartCategories.filter { $0.section == section }
    }
    
    func moveChartCategory(fromOffsets: IndexSet, toOffset: Int) {
        chartCategories.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func moveFingeringChartInChartCategory(categoryName: String, fromOffsets: IndexSet, toOffset: Int) {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName) {
            chartCategories[chartCategoryIndex].fingeringCharts.move(fromOffsets: fromOffsets, toOffset: toOffset)
        }
    }
    
    func moveNoteFingeringInFingeringChart(categoryName: String, instrumentType: InstrumentType, firstNote: Note, fromOffsets: IndexSet, toOffset: Int) {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: instrumentType), let noteFingeringIndex = noteFingeringIndex(in: chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex], firstNote: firstNote) {
            chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex].fingerings.move(fromOffsets: fromOffsets, toOffset: toOffset)
        }
    }
    
    func deleteChartCategory(atOffsets offsets: IndexSet) {
        chartCategories.remove(atOffsets: offsets)
    }
    
    func deleteFingeringChartInChartCategory(categoryName: String, atOffsets offsets: IndexSet) {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName) {
            chartCategories[chartCategoryIndex].fingeringCharts.remove(atOffsets: offsets)
        }
    }
    
    func deleteFingeringInFingeringChart(categoryName: String, instrumentType: InstrumentType, firstNote: Note, atOffsets offsets: IndexSet) {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: instrumentType), let noteFingeringIndex = noteFingeringIndex(in: chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex], firstNote: firstNote) {
            chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex].fingerings.remove(atOffsets: offsets)
        }
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
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName) {
            chartCategories[chartCategoryIndex].fingeringCharts.append(chart)
        }
    }
    
    func updateChart(in categoryName: String, chart: FingeringChart) {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: chart.instrument.type) {
            chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex] = chart
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

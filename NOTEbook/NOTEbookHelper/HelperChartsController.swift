//
//  HelperChartsController.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 3/24/22.
//

import Common
import Foundation
import SwiftUI

class HelperChartsController: ObservableObject {
    static let shared = HelperChartsController()

    @Published private(set) var chartCategories = [ChartCategory]()

    // MARK: - Initializer

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

    func chartCategories(in section: ChartSection) -> [ChartCategory] {
        chartCategories.filter { $0.section == section }
    }

    private func chartCategory(with categoryName: String) -> ChartCategory? {
        chartCategories.first { $0.name == categoryName }
    }

    private func fingeringChart(in categoryName: String, instrumentType: Instrument.InstrumentType) -> FingeringChart? {
        chartCategory(with: categoryName)?.fingeringCharts.first { $0.instrument.type == instrumentType }
    }

    // MARK: - Index Getters

    private func firstIndexOfSection(section: ChartSection) -> Int? {
        chartCategories.firstIndex { $0.section == section }
    }

    private func chartCategoryIndex(with categoryName: String) -> Int? {
        chartCategories.firstIndex { $0.name == categoryName }
    }

    private func fingeringChartIndex(in category: ChartCategory, instrumentType: Instrument.InstrumentType) -> Int? {
        category.fingeringCharts.firstIndex { $0.instrument.type == instrumentType }
    }

    private func noteFingeringIndex(in chart: FingeringChart, firstNote: Note) -> Int? {
        chart.noteFingerings.firstIndex { $0.notes[0] == firstNote }
    }

    // MARK: - Binding Getters

    func bindingToCategoryName(categoryName: String) -> Binding<String>? {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName) {
            return Binding {
                self.chartCategories[chartCategoryIndex].name
            } set: { newName in
                self.chartCategories[chartCategoryIndex].type = ChartCategoryType(rawValue: newName) ?? ChartCategoryType(rawValue: categoryName)!
            }
        }
        return nil
    }

    func bindingToFingeringChart(in categoryName: String, instrumentType: Instrument.InstrumentType) -> Binding<FingeringChart>? {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: instrumentType) {
            return Binding {
                self.chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex]
            } set: { newFingeringChart in
                self.chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex] = newFingeringChart
            }
        }
        return nil
    }

    // MARK: - Move Methods

    func moveChartCategory(section: ChartSection, fromOffsets: IndexSet, toOffset: Int) {
        guard let firstIndexOfSection = firstIndexOfSection(section: section),
              let fromOffsetFirst = fromOffsets.first else { return }

        let fromIndex = firstIndexOfSection + fromOffsetFirst
        let toIndex = firstIndexOfSection + toOffset

        chartCategories.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex)

        save()
    }

    func moveFingeringChartInChartCategory(categoryName: String, fromOffsets: IndexSet, toOffset: Int) {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName) {
            chartCategories[chartCategoryIndex].fingeringCharts.move(fromOffsets: fromOffsets, toOffset: toOffset)
            save()
        }
    }

    @discardableResult func moveNoteFingeringInFingeringChart(categoryName: String, instrumentType: Instrument.InstrumentType, firstNote: Note, fromOffsets: IndexSet, toOffset: Int) -> NoteFingering? {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: instrumentType), let noteFingeringIndex = noteFingeringIndex(in: chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex], firstNote: firstNote) {
            chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex].fingerings.move(fromOffsets: fromOffsets, toOffset: toOffset)
            save()
            return chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex]
        }
        return nil
    }

    // MARK: - Delete Methods

    func deleteChartCategory(section: ChartSection, atOffsets: IndexSet) {
        guard let firstOffset = atOffsets.first,
              let firstIndexOfSection = firstIndexOfSection(section: section) else { return }
        let index = firstOffset + firstIndexOfSection
        chartCategories.remove(at: index)
        save()
    }

    func deleteFingeringChartInChartCategory(categoryName: String, atOffsets offsets: IndexSet) {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName) {
            chartCategories[chartCategoryIndex].fingeringCharts.remove(atOffsets: offsets)
            save()
        }
    }

    @discardableResult func deleteNoteFingeringInFingeringChart(categoryName: String, instrumentType: Instrument.InstrumentType, firstNote: Note, atOffsets offsets: IndexSet) -> NoteFingering? {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: instrumentType), let noteFingeringIndex = noteFingeringIndex(in: chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex], firstNote: firstNote) {
            chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex].fingerings.remove(atOffsets: offsets)
            save()
            return chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex]
        }
        return nil
    }

    // MARK: - Add Methods

    func addChartCategory(category: ChartCategory) {
        let categorySection = category.section

        var indexToInsertAt: Int?

        let lastIndexOfSection = chartCategories.lastIndex { categorySection == $0.section }

        if let lastIndexOfSection {
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

        if let indexToInsertAt {
            chartCategories.insert(category, at: indexToInsertAt)
            save()
        } else {
            print("Chart Category is not able to be added as it is an edge case")
        }
    }

    func addFingeringChart(in categoryName: String, fingeringChart: FingeringChart) {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName) {
            chartCategories[chartCategoryIndex].fingeringCharts.append(fingeringChart)
            save()
        }
    }

    @discardableResult func addFingering(in categoryName: String, instrumentType: Instrument.InstrumentType, firstNote: Note, fingering: Fingering) -> NoteFingering? {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: instrumentType), let noteFingeringIndex = noteFingeringIndex(in: chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex], firstNote: firstNote) {
            chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex].fingerings.append(fingering)
            save()
            return chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex]
        }
        return nil
    }

    // MARK: - Update Methods

    func updateFingeringChart(in categoryName: String, fingeringChart: FingeringChart) {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: fingeringChart.instrument.type) {
            chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex] = fingeringChart
            save()
        }
    }

    @discardableResult func updateFingering(in categoryName: String, instrumentType: Instrument.InstrumentType, firstNote: Note, fingeringIndex: Int, fingering: Fingering) -> NoteFingering? {
        if let chartCategoryIndex = chartCategoryIndex(with: categoryName), let fingeringChartIndex = fingeringChartIndex(in: chartCategories[chartCategoryIndex], instrumentType: instrumentType), let noteFingeringIndex = noteFingeringIndex(in: chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex], firstNote: firstNote) {
            chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex].fingerings[fingeringIndex] = fingering
            save()
            return chartCategories[chartCategoryIndex].fingeringCharts[fingeringChartIndex].noteFingerings[noteFingeringIndex]
        }
        return nil
    }

    // MARK: - Generators

    func generateNoteList(minNote: Note, maxNote: Note, listNoteType: NoteType) -> [Note] {
        var list = [minNote.transpose(to: listNoteType)]
        var currentNote = minNote

        while currentNote != maxNote {
            currentNote = currentNote.higherNote()
            list.append(currentNote.transpose(to: listNoteType))
        }

        return list
    }

    func generateNoteFingerings(in categoryName: String, instrumentType: Instrument.InstrumentType, naturalNotes: [Note], flatNotes: [Note], sharpNotes: [Note]) -> [NoteFingering] {
        var newNoteFingerings = [NoteFingering]()

        var index = 0

        if flatNotes[index].type == .flat {
            let flatNote = flatNotes[index]
            let sharpNote = flatNote.transposeDownHalfStep().transposeUpHalfStep()
            newNoteFingerings.append(NoteFingering(notes: [sharpNote, flatNote], fingerings: []))
        } else {
            newNoteFingerings.append(NoteFingering(notes: [flatNotes[index]], fingerings: []))
        }

        newNoteFingerings.append(NoteFingering(notes: [naturalNotes[index]], fingerings: []))

        if sharpNotes[index].type == .sharp {
            let sharpNote = sharpNotes[index]
            let flatNote = sharpNote.transposeUpHalfStep().transposeDownHalfStep()
            newNoteFingerings.append(NoteFingering(notes: [sharpNote, flatNote], fingerings: []))
        } else if naturalNotes.count == 1 {
            let sharpNote = sharpNotes[index]
            newNoteFingerings.append(NoteFingering(notes: [sharpNote], fingerings: []))
        }

        index += 1

        while index < naturalNotes.count {
            newNoteFingerings.append(NoteFingering(notes: [naturalNotes[index]], fingerings: []))

            if sharpNotes[index].type == .sharp {
                let flatNote: Note

                if index == naturalNotes.count - 1 {
                    flatNote = sharpNotes[index].transposeUpHalfStep().transposeDownHalfStep()
                } else {
                    flatNote = flatNotes[index + 1]
                }

                let sharpNote = sharpNotes[index]
                newNoteFingerings.append(NoteFingering(notes: [sharpNote, flatNote], fingerings: []))
            }

            index += 1
        }

        if let oldNoteFingerings = fingeringChart(in: categoryName, instrumentType: instrumentType)?.noteFingerings {
            var oldIndex = 0
            var newIndex = 0

            if let matchIndex = oldNoteFingerings.firstIndex(where: { $0.notes == newNoteFingerings[0].notes }) {
                oldIndex = matchIndex
            } else if let matchIndex = newNoteFingerings.firstIndex(where: { $0.notes == oldNoteFingerings[0].notes }) {
                newIndex = matchIndex
            }

            while oldIndex < oldNoteFingerings.count && newIndex < newNoteFingerings.count && oldNoteFingerings[oldIndex].notes == newNoteFingerings[newIndex].notes {
                newNoteFingerings[newIndex].fingerings = oldNoteFingerings[oldIndex].fingerings
                oldIndex += 1
                newIndex += 1
            }
        }

        return newNoteFingerings
    }

    func generateOffset(minNote: Note, maxNote: Note) -> Double {
        var minPositions = minNote.positionsFromCenterStaff()
        var maxPositions = maxNote.positionsFromCenterStaff()

        if minPositions >= -4 && minPositions <= 4 {
            minPositions = 0
        } else {
            minPositions = minPositions + (minPositions < 0 ? 4 : -4)
        }

        if maxPositions >= -4 && maxPositions <= 4 {
            maxPositions = 0
        } else {
            maxPositions = maxPositions + (maxPositions < 0 ? 4 : -4)
        }

        return Double(maxPositions + minPositions) / 4.0
    }

    // MARK: - Preview Data

    #if(DEBUG)

    static var exampleChartCategory = shared.chartCategory(with: "Trumpet")!
    static var exampleChart = exampleChartCategory.fingeringCharts.first!

    #endif
}

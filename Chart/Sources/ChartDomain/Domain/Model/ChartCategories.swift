//
//  ChartCategories.swift
//  ChartDomain
//
//  Created by Matt Free on 7/20/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import SwiftUI

public typealias ChartCategories = [ChartCategory]

extension ChartCategories {
    // MARK: - Getters

    public func categories(in section: ChartSection) -> [ChartCategory] {
        self.filter { $0.section == section }
    }

    public func categoryIndex(with id: UUID) -> Int? {
        self.firstIndex { $0.id == id }
    }

    public func chartIndex(in category: ChartCategory, with chartId: UUID) -> Int? {
        category.fingeringCharts.firstIndex { $0.id == chartId }
    }

    // MARK: - Index Getters

    private func firstIndexOfSection(_ section: ChartSection) -> Int? {
        self.firstIndex { $0.section == section }
    }

    // MARK: - Add

    public mutating func addCategory(_ category: ChartCategory) {
        self.append(category)
        sort()
    }

    public mutating func addChart(inParentWith parentCategoryId: UUID, chart: FingeringChart) {
        if let categoryIndex = categoryIndex(with: parentCategoryId) {
            self[categoryIndex].fingeringCharts.append(chart)
        }
    }

    // MARK: - Update

    public mutating func updateCategory(_ category: ChartCategory) {
        if let categoryIndex = categoryIndex(with: category.id) {
            self[categoryIndex] = category
            sort()
        }
    }

    public mutating func updateChart(inParentWith parentCategoryId: UUID, chart: FingeringChart) {
        if let categoryIndex = categoryIndex(with: parentCategoryId), let chartIndex = chartIndex(in: self[categoryIndex], with: chart.id) {
            self[categoryIndex].fingeringCharts[chartIndex] = chart
        }
    }

    // MARK: - Move

    public mutating func moveCategory(in section: ChartSection, from offsets: IndexSet, to offset: Int) {
        if let firstIndexOfSection = firstIndexOfSection(section),
           let fromOffsetFirst = offsets.first {
            let fromIndex = firstIndexOfSection + fromOffsetFirst
            let toIndex = firstIndexOfSection + offset
            self.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex)
        }
    }

    public mutating func moveChartInCategory(with categoryId: UUID, from offsets: IndexSet, to offset: Int) {
        if let categoryIndex = categoryIndex(with: categoryId) {
            self[categoryIndex].fingeringCharts.move(fromOffsets: offsets, toOffset: offset)
        }
    }

    // MARK: - Delete

    public mutating func deleteCategory(in section: ChartSection, at offsets: IndexSet) {
        if let firstIndexOfSection = firstIndexOfSection(section),
           let firstOffset = offsets.first {
            let index = firstOffset + firstIndexOfSection
            self.remove(at: index)
        }
    }

    public mutating func deleteCategory(with chartId: UUID) {
        self.removeAll { $0.id == chartId }
    }

    public mutating func deleteChartInCategory(with categoryId: UUID, at offsets: IndexSet) {
        if let categoryIndex = categoryIndex(with: categoryId) {
            self[categoryIndex].fingeringCharts.remove(atOffsets: offsets)
        }
    }

    public mutating func deleteChartInCategory(categoryId: UUID, chartId: UUID) {
        if let categoryIndex = categoryIndex(with: categoryId) {
            self[categoryIndex].fingeringCharts.removeAll { $0.id == chartId }
        }
    }

    // MARK: - Sort

    private mutating func sort() {
        self.sort { $0.section < $1.section }
    }
}

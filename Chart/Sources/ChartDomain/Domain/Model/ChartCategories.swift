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
    public func categories(in section: ChartSection) -> [ChartCategory] {
        self.filter { $0.section == section }
    }

    public func categoryIndex(with id: UUID) -> Int? {
        self.firstIndex { $0.id == id }
    }

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

    public mutating func deleteCategory(in section: ChartSection, at offsets: IndexSet) {
        if let firstIndexOfSection = firstIndexOfSection(section),
           let firstOffset = offsets.first {
            let index = firstOffset + firstIndexOfSection
            self.remove(at: index)
        }
    }

    public mutating func deleteChartInCategory(with categoryId: UUID, at offsets: IndexSet) {
        if let categoryIndex = categoryIndex(with: categoryId) {
            self[categoryIndex].fingeringCharts.remove(atOffsets: offsets)
        }
    }

    private func firstIndexOfSection(_ section: ChartSection) -> Int? {
        self.firstIndex { $0.section == section }
    }
}

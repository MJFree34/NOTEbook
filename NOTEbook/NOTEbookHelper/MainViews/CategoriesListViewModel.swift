//
//  CategoriesListViewModel.swift
//  NOTEbookHelper
//
//  Created by Matt Free on 6/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import Combine
import Common
import Foundation
import Storage
import SwiftUI

final class CategoriesListViewModel: ObservableObject {
    @DependencyInjected(FetchHelperChartsUseCase.self) private var fetchHelperChartsUseCase
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage
    @DependencyInjected(SaveChartsUseCase.self) private var saveChartsUseCase

    enum ScreenState: Equatable {
        case error(ChartError)
        case loaded
        case loading
    }

    @Published var chartCategories = ChartCategories()

    @Published var screenState: ScreenState = .loading
    @Published var sectionsExpanded = Dictionary(uniqueKeysWithValues: ChartSection.allCases.map { ($0, true) })
    @Published var categoriesExpanded = Dictionary(
        uniqueKeysWithValues: ["Flute", "Clarinet", "Saxophone", "Trumpet", "Mellophone", "French Horn", "Trombone", "Baritone Horn", "Euphonium", "Tuba"].map { ($0, false) })

    let chartsURL = URL.documentsDirectory.appendingPathComponent("\(Constants.chartsFilename).json")

    private var disposeBag = DisposeBag()

    func start() {
        fetchHelperChartsUseCase.execute(chartsFilename: Constants.chartsFilename)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.screenState = .error(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] chartCategories in
                self?.chartCategories = chartCategories
                self?.screenState = .loaded
            }
            .store(in: &disposeBag)
    }

    func moveCategory(in section: ChartSection, from offsets: IndexSet, to offset: Int) {
        chartCategories.moveCategory(in: section, from: offsets, to: offset)
        save()
    }

    func moveChartInCategory(with categoryId: UUID, from offsets: IndexSet, to offset: Int) {
        chartCategories.moveChartInCategory(with: categoryId, from: offsets, to: offset)
        save()
    }

    func deleteCategory(in section: ChartSection, at offsets: IndexSet) {
        chartCategories.deleteCategory(in: section, at: offsets)
        save()
    }

    func deleteChartInCategory(with categoryId: UUID, at offsets: IndexSet) {
        chartCategories.deleteChartInCategory(with: categoryId, at: offsets)
        save()
    }

    private func save() {
        do {
            try saveChartsUseCase.execute(chartsFilename: Constants.chartsFilename, chartCategories: chartCategories)
        } catch let error as ChartError {
            screenState = .error(error)
        } catch {
            screenState = .error(.unknownError)
        }
    }
}

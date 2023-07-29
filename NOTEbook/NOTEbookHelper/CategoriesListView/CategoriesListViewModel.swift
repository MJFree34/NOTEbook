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
    @DependencyInjected(FetchUserPreferencesUseCase.self) private var fetchUserPreferencesUseCase
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage
    @DependencyInjected(SaveChartsUseCase.self) private var saveChartsUseCase
    @DependencyInjected(SaveUserPreferencesUseCase.self) private var saveUserPreferencesUseCase

    enum ScreenState: Equatable {
        case error(ChartError)
        case loaded
        case loading
    }

    @Published var chartCategories = ChartCategories()

    @Published var screenState: ScreenState = .loading
    @Published var userPreferences = UserPreferences()

    let chartsURL = URL.documentsDirectory.appendingPathComponent("\(Constants.chartsFilename).json")

    private var disposeBag = DisposeBag()

    init() {
        setupObserving()
    }

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

        fetchUserPreferencesUseCase.execute(chartsFilename: Constants.chartsFilename)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.screenState = .error(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] userPreferences in
                self?.userPreferences = userPreferences
            }
            .store(in: &disposeBag)
    }

    func addCategory(_ category: ChartCategory) {
        chartCategories.addCategory(category)
    }

    func updateCategory(_ category: ChartCategory) {
        chartCategories.updateCategory(category)
    }

    func moveCategory(in section: ChartSection, from offsets: IndexSet, to offset: Int) {
        chartCategories.moveCategory(in: section, from: offsets, to: offset)
    }

    func moveChartInCategory(with categoryId: UUID, from offsets: IndexSet, to offset: Int) {
        chartCategories.moveChartInCategory(with: categoryId, from: offsets, to: offset)
    }

    func deleteCategory(in section: ChartSection, at offsets: IndexSet) {
        chartCategories.deleteCategory(in: section, at: offsets)
    }

    func deleteCategory(with categoryId: UUID) {
        chartCategories.deleteCategory(with: categoryId)
    }

    func deleteChartInCategory(with categoryId: UUID, at offsets: IndexSet) {
        chartCategories.deleteChartInCategory(with: categoryId, at: offsets)
    }

    func deleteChartInCategory(categoryId: UUID, chartId: String) {
        chartCategories.deleteChartInCategory(categoryId: categoryId, chartId: chartId)
    }

    private func setupObserving() {
        $userPreferences
            .receive(on: RunLoop.main)
            .sink { [weak self] newUserPreferences in
                self?.saveUserPreferences(newUserPreferences)
            }
            .store(in: &disposeBag)

        $chartCategories
            .receive(on: RunLoop.main)
            .sink { [weak self] newChartCategories in
                self?.saveCharts(newChartCategories)
            }
            .store(in: &disposeBag)
    }

    private func saveCharts(_ chartCategories: ChartCategories) {
        do {
            try saveChartsUseCase.execute(chartsFilename: Constants.chartsFilename, chartCategories: chartCategories)
        } catch let error as ChartError {
            screenState = .error(error)
        } catch {
            screenState = .error(.unknownError)
        }
    }

    private func saveUserPreferences(_ newUserPreferences: UserPreferences) {
        do {
            try saveUserPreferencesUseCase.execute(userPreferences: newUserPreferences)
        } catch let error as ChartError {
            screenState = .error(error)
        } catch {
            screenState = .error(.unknownError)
        }
    }
}

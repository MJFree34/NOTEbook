//
//  ChartsViewModel.swift
//  NOTEbook
//
//  Created by Matt Free on 6/15/23.
//

import Combine
import Foundation

final class ChartsViewModel: ObservableObject {
    enum ScreenState {
        case error(ChartLoadError)
        case loaded
        case loading
    }

    @DependencyInjected(ChartsRepository.self) private var chartsRepository

    @Published var screenState: ScreenState = .loading

    private var disposeBag = DisposeBag()
    private var chartCategories = [ChartCategory]()

    // MARK: - Init

    func start() {
        chartsRepository.loadCharts()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    guard let self else { return }
                    self.screenState = .error(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] chartCategories in
                guard let self else { return }
                self.chartCategories = chartCategories
                self.screenState = .loaded
            }
            .store(in: &disposeBag)
    }

    // MARK: - Saving

    private func save() {
        do {
            try chartsRepository.saveCharts(chartCategories: chartCategories)
        } catch {
            screenState = .error(.savingError)
        }
    }

    // MARK: - Getters

    private func chartCategory(of type: ChartCategory.CategoryType) -> ChartCategory? {
        chartCategories.first { $0.type == type }
    }
}

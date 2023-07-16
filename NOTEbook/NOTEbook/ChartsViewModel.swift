//
//  ChartsViewModel.swift
//  NOTEbook
//
//  Created by Matt Free on 6/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import ChartDomain
import Combine
import Common
import Foundation
import Storage

final class ChartsViewModel: ObservableObject {
    enum ScreenState {
        case error(ChartError)
        case loaded
        case loading
    }

    @DependencyInjected(FetchChartsUseCase.self) private var fetchChartsUseCase
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage

    @Published var screenState: ScreenState = .loading

    private var disposeBag = DisposeBag()
    private var chartCategories = [ChartCategory]()

    // MARK: - Init

    func start() {
        print("Before - ChartsCacheCreated: \(keyValueStorage.bool(for: .chartsCacheCreated))")
        print("Before - ChartsUpdatedFromNetwork: \(keyValueStorage.bool(for: .chartsUpdatedFromNetwork))")

        fetchChartsUseCase.execute(networkURLString: Constants.networkChartsURL, chartsFilename: Constants.chartsFilename)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard let self else { return }
                print("After - ChartsCacheCreated: \(self.keyValueStorage.bool(for: .chartsCacheCreated))")
                print("After - ChartsUpdatedFromNetwork: \(self.keyValueStorage.bool(for: .chartsUpdatedFromNetwork))")
                switch completion {
                case .failure(let error):
                    //                    guard let self else { return }
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

    // MARK: - Getters

    private func chartCategory(of type: ChartCategory.CategoryType) -> ChartCategory? {
        chartCategories.first { $0.type == type }
    }
}

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
    private var chartCategories = ChartCategories()

    // MARK: - Init

    func start() {
        fetchChartsUseCase.execute(
            networkURLString: Constants.networkChartsURL,
            chartsFilename: Constants.chartsFilename
        )
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
}

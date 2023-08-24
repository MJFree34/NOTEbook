//
//  ChartLocalDataSource.swift
//  ChartDomain
//
//  Created by Matt Free on 7/15/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Combine
import Common
import Foundation
import Storage

final class ChartLocalDataSource: ChartLocalDataSourceProtocol {
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage

    func fetchCharts(chartsFilename: String) -> AnyPublisher<ChartCategories, ChartError> {
        savedChartsData(chartsFilename: chartsFilename)
            .tryMap { url in
                try Data(contentsOf: url)
            }
            .decode(type: ChartCategories.self, decoder: JSONDecoder())
            .catch { _ in
                self.bundleChartsData(chartsFilename: chartsFilename)
                    .tryMap { url in
                        try Data(contentsOf: url)
                    }
                    .decode(type: ChartCategories.self, decoder: JSONDecoder())
            }
            .mapError { error -> ChartError in
                if let error = error as? ChartError {
                    return error
                }
                return ChartError.decodingError
            }
            .eraseToAnyPublisher()
    }

    private func bundleChartsData(chartsFilename: String) -> AnyPublisher<URL, ChartError> {
        guard let bundleChartsURL = Bundle.main.url(forResource: chartsFilename, withExtension: "json") else {
            return Fail(error: ChartError.invalidBundleURL)
                .eraseToAnyPublisher()
        }

        return Just(bundleChartsURL)
            .setFailureType(to: ChartError.self)
            .eraseToAnyPublisher()
    }

    private func savedChartsData(chartsFilename: String) -> AnyPublisher<URL, ChartError> {
        let savedChartsURL = URL.documentsDirectory.appendingPathComponent("\(chartsFilename).json")

        return Just(savedChartsURL)
            .setFailureType(to: ChartError.self)
            .eraseToAnyPublisher()
    }

    func saveCharts(chartsFilename: String, chartCategories: ChartCategories) throws {
        let chartsURL = URL.documentsDirectory.appendingPathComponent("\(chartsFilename).json")

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let data = try encoder.encode(chartCategories)
            try data.write(to: chartsURL)
            keyValueStorage.set(true, for: .chartsCacheCreated)
        } catch {
            throw ChartError.savingError
        }
    }

    func fetchUserPreferences(chartsFilename: String) -> AnyPublisher<UserPreferences, ChartError> {
        bundleChartsData(chartsFilename: chartsFilename)
            .tryMap { url in
                try Data(contentsOf: url)
            }
            .decode(type: ChartCategories.self, decoder: JSONDecoder())
            .tryMap { [weak self] chartCategories in
                guard let self else { throw ChartError.preferencesDecodingError }

                let defaultSectionsExpanded = Dictionary(uniqueKeysWithValues: ChartSection.allCases.map { ($0.rawValue, true) })
                let defaultCategoriesExpanded = Dictionary(uniqueKeysWithValues: chartCategories.map { ($0.name, true) })

                let sectionsExpanded: [String : Bool] = keyValueStorage.dictionary(for: .userSectionsExpanded) ?? defaultSectionsExpanded
                let categoriesExpanded: [String : Bool] = keyValueStorage.dictionary(for: .userCategoriesExpanded) ?? defaultCategoriesExpanded

                return UserPreferences(sectionsExpanded: sectionsExpanded, categoriesExpanded: categoriesExpanded)
            }
            .mapError { error -> ChartError in
                if let error = error as? ChartError {
                    return error
                }
                return ChartError.preferencesDecodingError
            }
            .eraseToAnyPublisher()
    }

    func saveUserPreferences(userPreferences: UserPreferences) throws {
        guard userPreferences != UserPreferences() else { return }
        keyValueStorage.set(userPreferences.sectionsExpanded, for: .userSectionsExpanded)
        keyValueStorage.set(userPreferences.categoriesExpanded, for: .userCategoriesExpanded)
    }
}

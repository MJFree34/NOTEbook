//
//  ChartsRepository.swift
//  NOTEbook
//
//  Created by Matt Free on 6/18/20.
//  Copyright © 2020 Matt Free. All rights reserved.
//

import Combine
import Foundation

struct ChartsRepository {
    @DependencyInjected(KeyValueStorage.self) private var keyValueStorage

    func loadCharts() -> AnyPublisher<[ChartCategory], ChartLoadError> {
        guard let networkChartsURL = Constants.networkChartsURL?
            .appendingPathComponent("\(Constants.chartsFilename).json") else {
            return Fail(error: ChartLoadError.invalidNetworkURL)
                .eraseToAnyPublisher()
        }

        keyValueStorage.set(true, for: .chartsUpdatedFromNetwork)

        return URLSession.shared
            .dataTaskPublisher(for: networkChartsURL)
            .retry(1)
            .mapError { _ in
                ChartLoadError.networkError
            }
            .map(\.data)
            .catch { _ in
                keyValueStorage.set(false, for: .chartsUpdatedFromNetwork)
                return fallbackDataPublisher()
            }
            .decode(type: [ChartCategory].self, decoder: JSONDecoder())
            .tryMap { chartCategories in
                try saveCharts(chartCategories: chartCategories)
                return chartCategories
            }
            .mapError { error -> ChartLoadError in
                if let error = error as? ChartLoadError {
                    return error
                }
                return ChartLoadError.unknownError
            }
            .eraseToAnyPublisher()
    }

    private func fallbackDataPublisher() -> AnyPublisher<Data, ChartLoadError> {
        let chartsCacheCreated = keyValueStorage.bool(for: .chartsCacheCreated)

        do {
            return Just(chartsCacheCreated ? try savedChartsData() : try bundleChartsData())
                .setFailureType(to: ChartLoadError.self)
                .eraseToAnyPublisher()
        } catch let error as ChartLoadError {
            return Fail(error: error)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: ChartLoadError.unknownError)
                .eraseToAnyPublisher()
        }
    }

    private func bundleChartsData() throws -> Data {
        guard let bundleChartsURL = Bundle.main
            .url(forResource: Constants.chartsFilename, withExtension: "json") else {
            throw ChartLoadError.invalidBundleURL
        }

        guard let data = try? Data(contentsOf: bundleChartsURL) else {
            throw ChartLoadError.unloadableData
        }

        return data
    }

    private func savedChartsData() throws -> Data {
        let savedChartsURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(Constants.chartsFilename).json")

        guard let data = try? Data(contentsOf: savedChartsURL) else {
            throw ChartLoadError.unloadableData
        }

        return data
    }

    func saveCharts(chartCategories: [ChartCategory]) throws {
        let chartsURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(Constants.chartsFilename).json")

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let data = try encoder.encode(chartCategories)
            try data.write(to: chartsURL)
            keyValueStorage.set(true, for: .chartsCacheCreated)
        } catch {
            throw ChartLoadError.savingError
        }
    }
}

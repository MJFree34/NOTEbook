//
//  ChartLoadError.swift
//  ChartDomain
//
//  Created by Matt Free on 7/10/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

import Foundation

public enum ChartError: LocalizedError {
    case decodingError
    case invalidBundleURL
    case invalidNetworkURL
    case networkError
    case preferencesDecodingError
    case savingError
    case unknownError
    case unloadableData

    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return "An error occurred while decoding."
        case .invalidBundleURL:
            return "An invalid bundle URL was inputted."
        case .invalidNetworkURL:
            return "An invalid network URL was inputted."
        case .networkError:
            return "A network error has occurred."
        case .preferencesDecodingError:
            return "An error occurred while decoding user preferences."
        case .savingError:
            return "An error occurred while saving Chart Categories."
        case .unknownError:
            return "An unknown chart error occurred."
        case .unloadableData:
            return "The chart data was unloadable."
        }
    }
}

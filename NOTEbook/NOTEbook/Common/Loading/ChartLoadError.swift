//
//  ChartLoadError.swift
//  NOTEbook
//
//  Created by Matt Free on 7/10/23.
//

import Foundation

enum ChartLoadError: Error {
    case decodingError
    case invalidBundleURL
    case invalidNetworkURL
    case networkError
    case savingError
    case unknownError
    case unloadableData
}

//
//  ChartLoadError.swift
//  ChartDomain
//
//  Created by Matt Free on 7/10/23.
//  Copyright © 2023 Matthew Free. All rights reserved.
//

public enum ChartError: Error {
    case decodingError
    case invalidBundleURL
    case invalidNetworkURL
    case networkError
    case savingError
    case unknownError
    case unloadableData
}

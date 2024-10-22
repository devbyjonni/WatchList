//
//  BundleError.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//


import Foundation

enum BundleError: LocalizedError {
    case fileNotFound(String)
    case failedToLoadData(String)
    case decodingFailed(Error)

    var errorDescription: String {
        switch self {
        case .fileNotFound(let fileName):
            return "File not found: \(fileName)"
        case .failedToLoadData(let fileName):
            return "Failed to load data from file: \(fileName)"
        case .decodingFailed(let error):
            return "Failed to decode the data from the bundle. Error: \(error.localizedDescription)"
        }
    }
}
//
//  DefaultBundleManager.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//


import Foundation

protocol BundleManaging {
    func loadJSONData<T: Decodable>(from fileName: String) throws -> T
}

final class DefaultBundleManager: BundleManaging {
    static let shared = DefaultBundleManager()

    private init() {}

    func loadJSONData<T: Decodable>(from fileName: String) throws -> T {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw BundleError.fileNotFound(fileName)
        }

        do {
            let data = try Data(contentsOf: url)
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                throw BundleError.decodingFailed(error)
            }
        } catch {
            throw BundleError.failedToLoadData(fileName)
        }
    }
}

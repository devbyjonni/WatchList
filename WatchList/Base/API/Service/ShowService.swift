//
//  ShowService.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//

import Foundation

protocol Service {
    func fetchData(source: DataSource) async throws -> Show
}

final class ShowService: Service {
    func fetchData(source: DataSource) async throws -> Show {
        switch source {
        case .remote(let endpoint):
            let networkManager = NetworkManager.shared
            return try await networkManager.fetchData(endpoint: endpoint)
        case .bundle(let fileName):
            let bundleManager = DefaultBundleManager.shared
            return try bundleManager.loadJSONData(from: fileName)
        }
    }
}

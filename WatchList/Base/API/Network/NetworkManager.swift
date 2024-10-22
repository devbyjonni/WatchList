//
//  NetworkManager.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//


import Foundation

protocol NetworkService {
    func fetchData<T: Decodable>(endpoint: String) async throws -> T
}

final class NetworkManager: NetworkService {
    static let shared = NetworkManager()
    private var session: URLSession

    private init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchData<T: Decodable>(endpoint: String) async throws -> T {
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL(endpoint)
        }

        let (data, response) = try await session.data(for: URLRequest(url: url))

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(code: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}

//
//  NetworkError.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//


import Foundation

enum NetworkError: LocalizedError {
    case invalidURL(String)
    case noData
    case decodingFailed(Error)
    case serverError(code: Int)
    case unknown(Error?)
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "The URL is invalid: \(url). Please check the URL and try again."
        case .noData:
            return "No data was received from the server. Please try again later."
        case .decodingFailed(let error):
            return "Failed to decode the data from the server. Error: \(error.localizedDescription)"
        case .serverError(let code):
            return "Server responded with an error: \(code). Please try again."
        case .unknown(let error):
            return "An unknown error occurred: \(error?.localizedDescription ?? "No further information available")."
        case .invalidResponse:
            return "The server response was invalid. Please try again."
        }
    }
}
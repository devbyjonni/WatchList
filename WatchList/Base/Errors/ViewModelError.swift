//
//  ViewModelError.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//


import Foundation

enum ViewModelError: Identifiable, CustomAlertError {
    case networkError(String)
    case unauthorizedAccess
    case unknown

    var id: String {
        UUID().uuidString
    }

    var title: String {
        switch self {
        case .networkError:
            return "Network Error"
        case .unauthorizedAccess:
            return "Unauthorized Access"
        case .unknown:
            return "Unknown Error"
        }
    }

    var message: String {
        switch self {
        case .networkError(let message):
            return message
        case .unauthorizedAccess:
            return "You don't have permission to access this resource."
        case .unknown:
            return "An unknown error occurred."
        }
    }

    var primaryButtonLabel: String {
        switch self {
        case .networkError:
            return "Try Again"
        case .unauthorizedAccess, .unknown:
            return "OK"
        }
    }

    var cancelButtonLabel: String {
        switch self {
        case .networkError:
            return "Cancel"
        case .unauthorizedAccess, .unknown:
            return "Dismiss"
        }
    }
}

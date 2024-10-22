//
//  LogMessages.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//


import Foundation
import os.log

struct LogMessages {
    static func fetchFailed(functionName: String = #function, error: String) {
        Logger.viewCycle.error("[\(functionName)] - Failed to fetch items: \(error).")
    }

    static func fetchSuccess(functionName: String = #function) {
        Logger.viewCycle.info("[\(functionName)] - Successfully fetched all items.")
    }

    static func successfullySyncedFavoriteStatus(functionName: String = #function) {
        Logger.viewCycle.info("[\(functionName)] - Successfully synced favorite statuses across all items.")
    }

    static func loadFromBundleFailed(functionName: String = #function, error: String) {
        Logger.viewCycle.error("[\(functionName)] - Failed to load items from bundle: \(error).")
    }
}

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")
}

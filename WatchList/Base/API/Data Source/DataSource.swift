//
//  DataSource.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-10-22.
//

import Foundation

enum DataSource {
    case remote(endpoint: String)
    case bundle(fileName: String)
}

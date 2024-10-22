//
//  FavoritesManager.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//


import Foundation

final class FavoritesManager {
    private let favoritesKey = "favoritesKey"
    private let userDefaults: UserDefaults = .standard
    private var favorites: Set<String> = []
    
    static var shared: FavoritesManager = .init()
    
    private init() {
        self.favorites = load()
    }
    
    private func save() {
        userDefaults.set(Array(favorites), forKey: favoritesKey)
    }
    
    private func load() -> Set<String> {
        return Set(userDefaults.array(forKey: favoritesKey) as? [String] ?? [])
    }
    
    func isFavorite(id: String) -> Bool {
        return favorites.contains(id)
    }
    
    func toggle(id: String) {
        if isFavorite(id: id) {
            print("Removing \(id) from favorites.")
            favorites.remove(id)
        } else {
            print("Adding \(id) to favorites.")
            favorites.insert(id)
        }
        save()
    }
}

//
//  EpisodeDetailViewModel.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-10-22.
//

import Foundation

@MainActor
final class EpisodeDetailViewModel: ObservableObject {
    @Published private(set) var episode: Episode
    private let favoritesManager: FavoritesManager

    init(episode: Episode, favoritesManager: FavoritesManager = .shared) {
        self.episode = episode
        self.favoritesManager = favoritesManager
    }
    
    func toggleFavorite() {
        favoritesManager.toggle(id: episode.id)
        episode.isFavorite.toggle()
        objectWillChange.send()
    }
}

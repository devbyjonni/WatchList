//
//  EpisodeCardViewModel.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//

import Foundation

class EpisodeCardViewModel: ObservableObject {
    private(set) var episode: Episode
    private var favoritesManager = FavoritesManager.shared
    
    init(episode: Episode) {
        self.episode = episode
    }
    
    func toggleFavorite() {
        favoritesManager.toggle(id: episode.id)
        episode.isFavorite.toggle()
        objectWillChange.send()
    }
}

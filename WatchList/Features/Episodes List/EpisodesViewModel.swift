//
//  EpisodesViewModel.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//

import Foundation

@MainActor
final class EpisodesViewModel: ObservableObject {
    @Published private(set) var isLoading = false
    @Published var viewModelError: ViewModelError?
    @Published var showFavorites: Bool
    
    private(set) var show: Show?
    private(set) var seasons: [Season] = []
    private let favoritesManager: FavoritesManager
    private let service: Service
    
    var filteredSeasons: [Season] {
        if showFavorites {
            // Collect all favorite episodes from all seasons
            let allFavoriteEpisodes = seasons.flatMap { season in
                season.episodes.filter { $0.isFavorite }
            }
            
            // Return a single section (season) with all the favorite episodes
            return allFavoriteEpisodes.isEmpty ? [] : [Season(episodes: allFavoriteEpisodes)]
        } else {
            // Return the original, unfiltered seasons with sections
            return seasons
        }
    }
    
    init(favoritesManager: FavoritesManager = .shared, service: Service = ShowService()) {
        self.favoritesManager = favoritesManager
        self.service = service
        self.showFavorites = false
    }
    
    private func fetchSeasons() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let show = try await service.fetchData(source: .bundle(fileName: "hbo-silicon-valley"))
            self.show = show
            
            seasons = show.seasons
            
            syncFavoriteStatus(seasons: seasons)
            
            LogMessages.fetchSuccess()
        } catch {
            viewModelError = .networkError(error.localizedDescription)
            
            LogMessages.fetchFailed(error: error.localizedDescription)
        }
    }
    
    private func syncFavoriteStatus(seasons: [Season]) {
        for (index, season) in seasons.enumerated() {
            season.seasonNumber = String(index + 1)
            
            // Sync favorite status for each episode in the season
            season.episodes.forEach { episode in
                episode.isFavorite = favoritesManager.isFavorite(id: episode.id)
            }
        }
        LogMessages.successfullySyncedFavoriteStatus()
    }
    
    // MARK: - Public Methods
    
    func loadSeasons() async {
        await fetchSeasons()
    }
    
    func retryFetchingSeasons() {
        Task {
            await fetchSeasons()
        }
    }
    
    func refreshSeasons() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulate delay for refresh
        await fetchSeasons()
    }
    
    func toggleFavorite(for episode: Episode) {
        favoritesManager.toggle(id: episode.id)
        episode.isFavorite.toggle()
        objectWillChange.send()
    }
    
    func reloadFavoriteStatus(for episode: Episode) {
        episode.isFavorite = favoritesManager.isFavorite(id: episode.id)
        objectWillChange.send()
    }
}

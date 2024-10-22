//
//  EpisodesView.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//

import SwiftUI

struct EpisodesView: View {
    @StateObject private var viewModel = EpisodesViewModel()
    @State private var path = NavigationPath()
    @State private var showFavorites = false
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(viewModel.filteredSeasons) { season in
                    Section(header: Text(showFavorites ? "Favorites" : "Season \(season.seasonNumber ?? "Unknown")")) {
                        ForEach(season.episodes) { episode in
                            Button {
                                path.append(episode)
                            } label: {
                                EpisodeCardView(episode: episode)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .refreshable { await viewModel.refreshSeasons() }
            .navigationTitle(viewModel.show?.title ?? "")
            .navigationDestination(for: Episode.self) { episode in
                EpisodeDetailView(episode: episode)
                    .navigationTitle(episode.title)
                    .toolbarTitleDisplayMode(.inline)
                    .onDisappear {
                        viewModel.reloadFavoriteStatus(for: episode)
                    }
            }
            .customToolbarToggleButton(toggleBinding: $showFavorites)
        }
        .customProgressViewOverlay(isLoading: viewModel.isLoading)
        .customAlert(errorBinding: $viewModel.viewModelError) {
            viewModel.retryFetchingSeasons()
        }
        .onChange(of: showFavorites) { _, newValue in
            viewModel.showFavorites.toggle()
        }
        .task { await viewModel.loadSeasons() }
    }
}

#Preview {
    EpisodesView()
}

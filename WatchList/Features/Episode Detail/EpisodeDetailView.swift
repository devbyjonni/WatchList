//
//  EpisodeDetailView.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-10-22.
//

import SwiftUI

struct EpisodeDetailView: View {
    @StateObject private var viewModel: EpisodeDetailViewModel
    @State private var showFavorites = false
    
    init(episode: Episode) {
        _viewModel = StateObject(wrappedValue: EpisodeDetailViewModel(episode: episode))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Poster Image
                PhotoLoader(urlStr: viewModel.episode.downloadURL(forImageSize: .large))
                
                // Title
                Text(viewModel.episode.title)
                    .font(.title)
                    .bold()
                
                // Plot
                Text(viewModel.episode.plot)
                    .font(.body)
                    .foregroundStyle(.secondary)
                
                // Ratings
                if let rating = viewModel.episode.ratings.first {
                    Text("Rating: \(rating.value) (\(rating.source))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Episode Details
                VStack(alignment: .leading) {
                    Text("Directed by: \(viewModel.episode.director)")
                    Text("Written by: \(viewModel.episode.writer)")
                    Text("Actors: \(viewModel.episode.actors)")
                    Text("Released: \(viewModel.episode.released)")
                    Text("Runtime: \(viewModel.episode.runtime)")
                    Text("IMDB Votes: \(viewModel.episode.imdbVotes)")
                }
                .font(.footnote)
                .foregroundColor(.gray)
            }
            .padding()
        }
        .customToolbarToggleButton(toggleBinding: $showFavorites)
        .onChange(of: showFavorites) { _, newValue in
            viewModel.toggleFavorite()
        }
    }
}

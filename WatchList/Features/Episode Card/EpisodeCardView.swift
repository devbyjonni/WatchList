//
//  EpisodeCardView.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//


import SwiftUI

struct EpisodeCardView: View {
    @StateObject var viewModel: EpisodeCardViewModel
    
    init(episode: Episode) {
        _viewModel = StateObject(wrappedValue: EpisodeCardViewModel(episode: episode))
    }

    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            Rectangle()
                .fill(.gray.opacity(0.1))
                .frame(width: 50, height: 50)
                .overlay(alignment: .center){
                    PhotoLoader(urlStr: viewModel.episode.downloadURL(forImageSize: .small))
                        .frame(width: 100)
                }
                .clipShape(RoundedRectangle(cornerRadius: 4))

            VStack(alignment: .leading) {
                Text(viewModel.episode.title)
                    .font(.headline)
                Text(viewModel.episode.plot)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            Spacer()
            customToggleButton(isSelected: viewModel.episode.isFavorite) {
                viewModel.toggleFavorite()
            }
        }
    }
}

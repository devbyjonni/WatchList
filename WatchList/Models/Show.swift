//
//  Show.swift
//  WatchList
//
//  Created by Jonni Akesson on 2024-09-30.
//

import Foundation

final class Show: Decodable {
    let title: String
    let seasons: [Season]
}

final class Season: Decodable, Identifiable {
    let id: String
    let episodes: [Episode]
    var seasonNumber: String?

    enum CodingKeys: String, CodingKey {
        case id
        case episodes
        case seasonNumber
    }

    init(id: String = UUID().uuidString, episodes: [Episode], seasonNumber: String? = nil) {
        self.id = id
        self.episodes = episodes
        self.seasonNumber = seasonNumber
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.episodes = try container.decode([Episode].self, forKey: .episodes)
        self.seasonNumber = try container.decodeIfPresent(String.self, forKey: .seasonNumber) 
    }
}

final class Episode: Decodable, Identifiable {
    var id: String { imdbID } // Using imdbID as the unique identifier
    let plot: String
    let rated: String
    let title: String
    let ratings: [Rating]
    let writer: String
    let actors: String
    let type: String
    let imdbVotes: String
    let seriesID: String
    let season: String
    let director: String
    let released: String
    let awards: String
    let genre: String?
    let imdbRating: String
    let poster: String
    let episode: String
    let language: String
    let country: String
    let runtime: String
    let imdbID: String
    let metascore: String?
    let response: String
    let year: String
    var isFavorite = false
    
    enum CodingKeys: String, CodingKey {
        case plot = "Plot"
        case rated = "Rated"
        case title = "Title"
        case ratings = "Ratings"
        case writer = "Writer"
        case actors = "Actors"
        case type = "Type"
        case imdbVotes = "imdbVotes"
        case seriesID = "seriesID"
        case season = "Season"
        case director = "Director"
        case released = "Released"
        case awards = "Awards"
        case genre = "Genre"
        case imdbRating = "imdbRating"
        case poster = "Poster"
        case episode = "Episode"
        case language = "Language"
        case country = "Country"
        case runtime = "Runtime"
        case imdbID = "imdbID"
        case metascore = "Metascore"
        case response = "Response"
        case year = "Year"
    }
}

final class Rating: Decodable {
    let source: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

// Image size enum for downloading images
enum ImageSize: String {
    case small = "_SX300"
    case medium = "_SX600"
    case large = "_SX900"
}

extension Episode {
    func downloadURL(forImageSize: ImageSize) -> String {
        switch forImageSize {
        case .small:
            return poster
        case .medium, .large:
            return poster.replacingOccurrences(of: "_SX300", with: forImageSize.rawValue)
        }
    }
}

extension Episode: Hashable {
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//
//  TVShowDetail.swift
//  TheMovieDB
//
//  Created by Luann Luna on 15/10/22.
//

import Foundation

public struct TVShowDetailModel: Decodable {
    let adult: Bool
    let backdropPath: String
    let createdBy: [Authors]
    let episodeRunTime: [Int]
    let firstAirDate: String
    let genres: [GenreModel]
    let homepage: String
    let id: Int
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: String
    let name: String
    let networks: [Production]
    let numberOfEpisodes, numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [Production]
    let seasons: [Season]
    let status, tagline, type: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case name
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case seasons
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - CreatedBy
public struct Authors: Decodable {
    let id: Int
    let creditID, name: String
    let gender: Int
    let profilePath: String

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}

// MARK: - Network
public struct Production: Decodable {
    let id: Int
    let name: String
    let logoPath: String?
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

// MARK: - Season
public struct Season: Decodable {
    let airDate: String
    let name: String
    let posterPath: String?
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case name
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

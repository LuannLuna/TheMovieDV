//
//  SeasonDetailModel.swift
//  TheMovieDB
//
//  Created by Luann Luna on 16/10/22.
//

import Foundation

// MARK: - Season
public struct SeasonDetailModel: Decodable {
    let id, airDate: String
    let episodes: [Episode]
    let name, overview: String
    let seasonID: Int
    let posterPath: String
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case airDate = "air_date"
        case episodes, name, overview
        case seasonID = "id"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

// MARK: - Episode
public struct Episode: Decodable {
    let airDate: String
    let episodeNumber, id: Int
    let name, overview, productionCode: String
    let runtime, seasonNumber, showID: Int
    let stillPath: String
    let voteAverage: Double
    let voteCount: Int
    let crew, guestStars: [Crew]

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id, name, overview
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case crew
        case guestStars = "guest_stars"
    }
}

// MARK: - Crew
public struct Crew: Decodable {
    let job: String?
    let department: String?
    let creditID: String
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: String
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let character: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case job, department
        case creditID = "credit_id"
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case character, order
    }
}

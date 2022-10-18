//
//  AccountModel.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

public struct AccountModel: Decodable {
    let avatar: Avatar?
    let id: Int?
    let iso639_1, iso3166_1, name: String?
    let includeAdult: Bool?
    let username: String?

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}

// MARK: - Avatar
public struct Avatar: Decodable {
    let gravatar: Gravatar?
    let tmdb: Tmdb?
}

// MARK: - Gravatar
public struct Gravatar: Decodable {
    let hash: String?
    
    var urlImage: String? {
        guard let hash = hash else { return nil }
        return "https://www.gravatar.com/avatar/\(hash).jpg?s=150"
    }
}

// MARK: - Tmdb
public struct Tmdb: Decodable {
    let avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}

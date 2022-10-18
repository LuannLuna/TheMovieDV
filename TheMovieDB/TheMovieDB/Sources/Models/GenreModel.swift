//
//  Genre.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

public struct GenreQueryResult: Decodable {
    let genres: [GenreModel]
}

public struct GenreModel: Decodable {
    let id: Int
    let name: String
}

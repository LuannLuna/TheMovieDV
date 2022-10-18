//
//  GenreQuery.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

enum GenreQuery: RestQuery {
    case movie
    case tv
    
    var path: String {
        switch self {
        case .movie:
            return "genre/movie/list"
        case .tv:
            return "genre/tv/list"
        }
    }
    
    var method: NetworkMethod { .get }
}

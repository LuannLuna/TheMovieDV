//
//  SeasonQuery.swift
//  TheMovieDB
//
//  Created by Luann Luna on 16/10/22.
//

import Foundation

enum SeasonQuery: RestQuery {
    case tvSeason(tvId: Int, season: Int)
    
    var path: String {
        switch self {
        case .tvSeason(let tvId, let season):
            return "tv/\(tvId)/season/\(season)"
        }
    }
    
    var method: NetworkMethod { .get }
}

//
//  TVQuery.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

public enum TVQuery: RestQuery {
    case popular
    case topRate
    case today
    case ontheair
    case detail(id: Int)
    
    public var path: String {
        switch self {
        case .popular:
            return "tv/popular"
        case .topRate:
            return "tv/top_rated"
        case .ontheair:
            return "tv/on_the_air"
        case .today:
            return "tv/airing_today"
        case .detail(let id):
            return "tv/\(id)"
        }
    }
    
    public var method: NetworkMethod { .get }
}

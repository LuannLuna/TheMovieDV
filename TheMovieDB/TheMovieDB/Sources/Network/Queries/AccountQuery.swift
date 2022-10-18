//
//  WatchList.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

public enum AccountQuery: RestQuery {
    case getAccountDetail(sessionId: String)
    case getWatchlist(accountId: Int, sessionId: String)
    case setIntoList(accountId: Int, sessionId: String)
    case removeFromList(accountId: Int, sessionId: String)
    
    public var path: String {
        switch self {
        case .getAccountDetail:
            return "account"
        case .getWatchlist(let id, _):
            return "account/\(id)/watchlist/tv"
        case .setIntoList(let id, _):
            return "account/\(id)/watchlist/tv"
        case .removeFromList(let id, _):
            return "account/\(id)/watchlist/tv"
        }
    }
    
    public var method: NetworkMethod {
        switch self {
        case .getWatchlist, .getAccountDetail:
            return .get
        default:
            return .post
        }
    }
    
    public var parameters: [String : String]? {
        switch self {
        case .getAccountDetail(let sessionId):
            return [
                "api_key": apiKey,
                "session_id": sessionId
            ]
        case .getWatchlist(_, let sessionId):
            return [
                "api_key": apiKey,
                "session_id": sessionId
            ]
        case .setIntoList(_, let sessionId):
            return [
                "api_key": apiKey,
                "session_id": sessionId
            ]
        case .removeFromList(_, let sessionId):
            return [
                "api_key": apiKey,
                "session_id": sessionId
            ]
        }
    }
    
    public var body: [String : Any]? {
        switch self {
        case .getWatchlist, .getAccountDetail: return nil
        case .setIntoList(let accountId, _):
            return [
                "media_type": "tv",
                "media_id": accountId,
                "watchlist": true
            ]
        case .removeFromList(let accountId, _):
            return [
                "media_type": "tv",
                "media_id": accountId,
                "watchlist": false
            ]
        }
    }
}

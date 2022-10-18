//
//  Authentication.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

public struct AuthenticationModel: Decodable {
    let success: Bool?
    let expiresAt: String?
    let requestToken: String?
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}

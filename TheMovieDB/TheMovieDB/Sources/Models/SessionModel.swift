//
//  SessionModel.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

public struct SessionModel: Decodable {
    let success: Bool
    let sessionID: String

    enum CodingKeys: String, CodingKey {
        case success
        case sessionID = "session_id"
    }
}

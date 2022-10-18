//
//  AuthenticationQuery.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

public enum AuthenticationQuery: RestQuery {
    case token
    case login(username: String, password: String, token: String)
    case session(token: String)
    
    public var path: String {
        switch self {
        case .token:
            return "authentication/token/new"
        case .login:
            return "authentication/token/validate_with_login"
        case .session:
            return "authentication/session/new"
        }
    }
    
    public var body: [String : Any]? {
        switch self {
        case .login(let username, let password, let token):
            return [
                "username" : username,
                "password" : password,
                "request_token" : token
            ]
        case .session(let token):
            return [
                "request_token" : token
            ]
        default: return nil
        }
    }
    
    public var method: NetworkMethod {
        switch self {
        case .token: return .get
        case .login, .session: return .post
        }
    }
}

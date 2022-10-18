//
//  AuthenticationService.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

public typealias AuthenticationCallback = (Result<AuthenticationModel, NetworkError>) -> Void
public typealias SessionCallback = (Result<SessionModel, NetworkError>) -> Void

public protocol AuthenticationServiceProtocol {
    func validateToken(username: String, password: String, token: String, callback: @escaping AuthenticationCallback)
    func generateToken(callback: @escaping AuthenticationCallback)
    func generateSessionId(token: String, callback: @escaping SessionCallback)
}

public class AuthenticationService: AuthenticationServiceProtocol {
    private let network: NetworkProtocolType
    
    public init(network: NetworkProtocolType = Network.shared) {
        self.network = network
    }
    
    public func validateToken(username: String, password: String, token: String, callback: @escaping AuthenticationCallback) {
        let query: AuthenticationQuery = .login(username: username, password: password, token: token)
        network.call(query, AuthenticationModel.self) { result in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    public func generateToken(callback: @escaping AuthenticationCallback) {
        let query: AuthenticationQuery = .token
        network.call(query, AuthenticationModel.self) { result in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    public func generateSessionId(token: String, callback: @escaping SessionCallback) {
        let query: AuthenticationQuery = .session(token: token)
        network.call(query, SessionModel.self) { result in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

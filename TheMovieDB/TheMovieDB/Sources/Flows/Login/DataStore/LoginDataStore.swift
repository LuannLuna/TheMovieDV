//
//  LoginDataStore.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

protocol LoginDataStore {
    func generateToken() async throws -> String?
    func validateToken(username: String, password: String, oldToken: String) async throws -> AuthenticationModel
    func generateSessionId(token: String) async throws -> String?
}

class LoginDataStoreImpl: LoginDataStore {
    
    let loginService: AuthenticationServiceProtocol
    
    init(loginService: AuthenticationServiceProtocol) {
        self.loginService = loginService
    }
    
    func generateToken() async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            guard !Task.isCancelled else {
              continuation.resume(throwing: CancellationError())
              return
            }
            
            loginService.generateToken { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let response):
                    continuation.resume(returning: response.requestToken)
                }
            }
        }
    }
    
    func validateToken(username: String, password: String, oldToken: String) async throws -> AuthenticationModel {
        return try await withCheckedThrowingContinuation { continuation in
            guard !Task.isCancelled else {
              continuation.resume(throwing: CancellationError())
              return
            }

            loginService.validateToken(username: username, password: password, token: oldToken) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let response):
                    continuation.resume(returning: response)
                }
            }
        }
    }
    
    func generateSessionId(token: String) async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            guard !Task.isCancelled else {
              continuation.resume(throwing: CancellationError())
              return
            }
            
            loginService.generateSessionId(token: token) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let response):
                    continuation.resume(returning: response.sessionID)
                }
            }
        }
    }
}

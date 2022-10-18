//
//  ProfileDataStore.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

protocol ProfileDataStore {
    func loadWatchList(accountId: Int, sessionId: String) async throws -> [TVModel]
    func loadAccountDetail(sessionId: String) async throws -> AccountModel
}

class ProfileDataStoreImpl: ProfileDataStore {
    
    let watchListService: WatchListServiceProtocol
    
    init(watchListService: WatchListServiceProtocol) {
        self.watchListService = watchListService
    }
    
    func loadWatchList(accountId: Int, sessionId: String) async throws -> [TVModel] {
        
        let query: AccountQuery = .getWatchlist(accountId: accountId, sessionId: sessionId)
        
        return try await withCheckedThrowingContinuation { continuation in
            guard !Task.isCancelled else {
              continuation.resume(throwing: CancellationError())
              return
            }
            
            watchListService.fetchWatchList(query: query) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let response):
                    continuation.resume(returning: response.results)
                }
            }
        }
    }
    
    func loadAccountDetail(sessionId: String) async throws -> AccountModel {
        let query: AccountQuery = .getAccountDetail(sessionId: sessionId)
        
        return try await withCheckedThrowingContinuation { continuation in
            guard !Task.isCancelled else {
              continuation.resume(throwing: CancellationError())
              return
            }
            
            watchListService.getAccountDetail(query: query) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let response):
                    continuation.resume(returning: response)
                }
            }
        }
    }
}

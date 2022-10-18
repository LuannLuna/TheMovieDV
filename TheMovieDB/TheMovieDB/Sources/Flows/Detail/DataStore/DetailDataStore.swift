//
//  DetailDataStore.swift
//  TheMovieDB
//
//  Created by Luann Luna on 15/10/22.
//

import Foundation

protocol DetailDataStore {
    func loadTvShowDetail(query: TVQuery) async throws -> TVShowDetailModel
}

class DetailDataStoreImpl: DetailDataStore {
    
    let tvService: TVServiceProtocol
    
    init(tvService: TVServiceProtocol) {
        self.tvService = tvService
    }
    
    func loadTvShowDetail(query: TVQuery) async throws -> TVShowDetailModel {
        return try await withCheckedThrowingContinuation { continuation in
            guard !Task.isCancelled else {
              continuation.resume(throwing: CancellationError())
              return
            }
            tvService.fetchTVDetail(query: query) { result in
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

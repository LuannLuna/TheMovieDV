//
//  HomeDataStoreImpl.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

protocol HomeDataStore {
    func loadTvShows(query: TVQuery) async throws -> [TVModel]
}

class HomeDataStoreImpl: HomeDataStore {
    
    let tvService: TVServiceProtocol
    
    init(tvService: TVServiceProtocol) {
        self.tvService = tvService
    }
    
    func loadTvShows(query: TVQuery) async throws -> [TVModel] {
        return try await withCheckedThrowingContinuation { continuation in
            guard !Task.isCancelled else {
              continuation.resume(throwing: CancellationError())
              return
            }
            
            tvService.fetchTVData(query: query) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let response):
                    continuation.resume(returning: response.results)
                }
            }
        }
    }
}

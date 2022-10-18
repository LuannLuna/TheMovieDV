//
//  HomeDataStoreMock.swift
//  TheMovieDBTests
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

@testable import TheMovieDB

class HomeDataStoreMock: HomeDataStore {
    
    var tvService: TVServiceProtocol!
    
    init(_ result: ResultCase) {
        self.tvService = TVServiceMock(result: result)
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

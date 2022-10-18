//
//  SeasonsDataSource.swift
//  TheMovieDB
//
//  Created by Luann Luna on 16/10/22.
//

import Foundation

protocol SeasonsDataStore {
    func loadSeasonsDetail(season: Int) async throws -> SeasonDetailModel
}

class SeasonsDataStoreImpl: SeasonsDataStore {
    
    let seasonService: SeasonServiceProtocol
    let tvShowId: Int
    
    init(tvShowId: Int, seasonService: SeasonServiceProtocol) {
        self.tvShowId = tvShowId
        self.seasonService = seasonService
    }
    
    func loadSeasonsDetail(season: Int) async throws -> SeasonDetailModel {
        return try await withCheckedThrowingContinuation { continuation in
            guard !Task.isCancelled else {
              continuation.resume(throwing: CancellationError())
              return
            }
            seasonService.fetchSeasonData(id: tvShowId, season: season) { result in
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

//
//  SeasonService.swift
//  TheMovieDB
//
//  Created by Luann Luna on 16/10/22.
//

import Foundation

public typealias SeasonCallback = (Result<SeasonDetailModel, NetworkError>) -> Void

public protocol SeasonServiceProtocol {
    func fetchSeasonData(id: Int, season: Int, callback: @escaping SeasonCallback)
}

public class SeasonService: SeasonServiceProtocol {
    private let network: NetworkProtocolType
    
    public init(network: NetworkProtocolType = Network.shared) {
        self.network = network
    }
    
    public func fetchSeasonData(id: Int, season: Int, callback: @escaping SeasonCallback) {
        let query: SeasonQuery = .tvSeason(tvId: id, season: season)
        network.call(query, SeasonDetailModel.self) { result in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

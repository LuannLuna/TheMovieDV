//
//  TVService.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

public typealias TVCallback = (Result<TVQueryResult, NetworkError>) -> Void
public typealias TVDetailCallback = (Result<TVShowDetailModel, NetworkError>) -> Void

public protocol TVServiceProtocol {
    func fetchTVData(query: TVQuery, callback: @escaping TVCallback)
    func fetchTVDetail(query: TVQuery, callback: @escaping TVDetailCallback)
}

public class TVService: TVServiceProtocol {
    
    private var network: NetworkProtocolType
    
    public init(network: NetworkProtocolType = Network.shared) {
        self.network = network
    }
    
    public func fetchTVData(query: TVQuery, callback: @escaping TVCallback) {
        network.call(query, TVQueryResult.self) { result in
            switch result  {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    public func fetchTVDetail(query: TVQuery, callback: @escaping TVDetailCallback) {
        network.call(query, TVShowDetailModel.self) { result in
            switch result  {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

//
//  WatchListService.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

public typealias AccounCallback = (Result<AccountModel, NetworkError>) -> Void

public protocol WatchListServiceProtocol {
    func fetchWatchList(query: AccountQuery, callback: @escaping TVCallback)
    func getAccountDetail(query: AccountQuery, callback: @escaping AccounCallback)
}

public class WatchListService: WatchListServiceProtocol {
    
    private var network: NetworkProtocolType
    
    public init(network: NetworkProtocolType = Network.shared) {
        self.network = network
    }
    
    public func fetchWatchList(query: AccountQuery, callback: @escaping TVCallback) {
        network.call(query, TVQueryResult.self) { result in
            switch result  {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    public func getAccountDetail(query: AccountQuery, callback: @escaping AccounCallback) {
        network.call(query, AccountModel.self) { result in
            switch result  {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}

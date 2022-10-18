//
//  TVServiceMock.swift
//  TheMovieDBTests
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

@testable import TheMovieDB

class TVServiceMock: TVServiceProtocol {
    
    var result: ResultCase
    
    init(result: ResultCase) {
        self.result = result
    }
    
    func fetchTVData(query: TVQuery, callback: @escaping TVCallback) {
        switch result {
        case .success:
            let tvShows: TVQueryResult = LocalFileJSON.get("TVShowMock")
            callback(.success(tvShows))
        case .failure:
            callback(.failure(.dataNotFound))
        }
    }
    
    func fetchTVDetail(query: TVQuery, callback: @escaping TVDetailCallback) {
        switch result {
        case .success:
            let tvShow: TVShowDetailModel = LocalFileJSON.get("TVShowDetailMock")
            callback(.success(tvShow))
        case .failure:
            callback(.failure(.dataNotFound))
        }
    }
}

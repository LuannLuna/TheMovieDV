//
//  SeasonsServiceMock.swift
//  TheMovieDBTests
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

@testable import TheMovieDB

class SeasonsServiceMock: SeasonServiceProtocol {
    
    var result: ResultCase
    
    init(result: ResultCase) {
        self.result = result
    }
    
    func fetchSeasonData(id: Int, season: Int, callback: @escaping TheMovieDB.SeasonCallback) {
        switch result {
        case .success:
            let season: SeasonDetailModel = LocalFileJSON.get("SeasonMock")
            callback(.success(season))
        case .failure:
            callback(.failure(.dataNotFound))
        }
    }
}

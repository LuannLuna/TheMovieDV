//
//  SeasonsDataStoreTests.swift
//  TheMovieDBTests
//
//  Created by Luann Luna on 17/10/22.
//

import XCTest

@testable import TheMovieDB

final class SeasonsDataStoreTests: XCTestCase {

    var seasonService: SeasonServiceProtocol!
    
    func test_load_single_season_detail_success() {
        seasonService = SeasonsServiceMock(result: .success)
        seasonService.fetchSeasonData(id: 1413, season: 0) { result in
            switch result {
            case .failure:
                XCTFail("Test should succeed")
            case .success(let response):
                XCTAssertEqual(response.name, "Specials")
                XCTAssertEqual(response.episodes.count, 9)
            }
        }
    }
    
    func test_load_single_season_detail_fail() {
        seasonService = SeasonsServiceMock(result: .failure)
        seasonService.fetchSeasonData(id: 1413, season: 0) { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("Test should fail")
            }
        }
    }

}

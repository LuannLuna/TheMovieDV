//
//  DetailDataStoreTests.swift
//  TheMovieDBTests
//
//  Created by Luann Luna on 17/10/22.
//

import XCTest

@testable import TheMovieDB

final class DetailDataStoreTests: XCTestCase {

    var tvService: TVServiceProtocol!
    
    func test_load_tvShow_detail_success() {
        tvService = TVServiceMock(result: .success)
        tvService.fetchTVDetail(query: .detail(id: 1396)) { result in
            switch result {
            case .failure:
                XCTFail("Test should succeed")
            case .success(let response):
                XCTAssertEqual(response.name, "Breaking Bad")
                XCTAssertEqual(response.networks.count, 1)
            }
        }
    }
    
    func test_load_tvShow_detail_fail() {
        tvService = TVServiceMock(result: .failure)
        tvService.fetchTVDetail(query: .detail(id: 1396)) { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("Test should fail")
            }
        }
    }
}

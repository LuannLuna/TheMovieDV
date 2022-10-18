//
//  HomeDataStoreTests.swift
//  TheMovieDBTests
//
//  Created by Luann Luna on 17/10/22.
//

import XCTest

@testable import TheMovieDB

final class HomeDataStoreTests: XCTestCase {
    
    var tvService: TVServiceProtocol!

    func test_load_tvShow_success() {
        tvService = TVServiceMock(result: .success)
        tvService.fetchTVData(query: .popular) { result in
            switch result {
            case .failure:
                XCTFail("Test should succeed")
            case .success(let response):
                XCTAssertNotNil(response.results)
                XCTAssertEqual(response.results.count, 20)
            }
        }
    }
    
    func test_load_tvShow_fail() {
        tvService = TVServiceMock(result: .failure)
        tvService.fetchTVData(query: .popular) { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .success:
                XCTFail("Test should fail")
            }
        }
    }
}

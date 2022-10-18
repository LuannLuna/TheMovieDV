//
//  HomeViewModelTests.swift
//  TheMovieDBTests
//
//  Created by Luann Luna on 17/10/22.
//

import XCTest

@testable import TheMovieDB

final class HomeViewModelTests: XCTestCase {

    var homeViewModel: HomeViewModel!
    
    func test_load_home_success() async {
        homeViewModel = HomeViewModel(dataStore: HomeDataStoreMock(.success))
        
        XCTAssertEqual(homeViewModel.tvs.count, 0)
        await homeViewModel.requestTvShows()
        XCTAssertFalse(homeViewModel.tvs.isEmpty)
        XCTAssertEqual(homeViewModel.tvs[0].name, "House of the Dragon")
    }
    
    func test_load_home_fail() async {
        homeViewModel = HomeViewModel(dataStore: HomeDataStoreMock(.failure))
        
        XCTAssertEqual(homeViewModel.tvs.count, 0)
        await homeViewModel.requestTvShows()
        XCTAssertTrue(homeViewModel.tvs.isEmpty)
        
    }

}

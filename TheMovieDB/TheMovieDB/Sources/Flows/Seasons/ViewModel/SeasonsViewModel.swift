//
//  SeasonsViewModel.swift
//  TheMovieDB
//
//  Created by Luann Luna on 16/10/22.
//

import UIKit
import SwiftUI

protocol SeasonsViewModelProtocol: AnyObject { }

class SeasonsViewModel: ObservableObject, SeasonsViewModelProtocol {
    
    let dataStore: SeasonsDataStore
    @Published var seasonsDetail: [Int: SeasonDetailModel] = [:]
    @Published var isLoading: Bool = false
    let seasons: [Season]
    
    init(seasons: [Season], dataStore: SeasonsDataStore) {
        self.seasons = seasons
        self.dataStore = dataStore
    }
    
    @MainActor
    func fetchSeasonsData() async throws {
        isLoading = true
        defer { isLoading = false }
        await seasons.asyncForEach { s in
            let result = try? await dataStore.loadSeasonsDetail(season: s.seasonNumber)
            seasonsDetail[s.seasonNumber] = result
        }
    }
}

extension Sequence {
    func asyncForEach(_ operation: (Element) async throws -> Void) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
}

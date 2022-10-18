//
//  HomeViewModel.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func showSelected(_ tvShow: TVModel)
    func viewProfile()
    func logout()
}

class HomeViewModel: ObservableObject {
    
    enum TabOptions: String, CaseIterable, Equatable {
        case popular = "Popular"
        case topRate = "Top Rate"
        case onTv = "On Tv"
        case today = "Airing Today"
    }
    
    weak var delegate: HomeViewModelDelegate?
    @Published var currentTab: TabOptions = .popular {
        didSet {
            Task {
                await requestTvShows()
            }
        }
    }
    @Published var tvs: [TVModel]
    @Published var isLoading: Bool = false
    var dataStore: HomeDataStore
    
    init(dataStore: HomeDataStore) {
        self.dataStore = dataStore
        self.tvs = []
    }
    
    @MainActor
    func requestTvShows() async {
        isLoading = true
        defer { isLoading = false }
        var query: TVQuery
        switch currentTab {
            case .popular: query = .popular
            case .today: query = .today
            case .topRate: query = .topRate
            case .onTv: query = .ontheair
        }
        let result = try? await dataStore.loadTvShows(query: query)
        self.tvs = result ?? []
    }
    
    func showSelected(tvShow: TVModel) {
        delegate?.showSelected(tvShow)
    }
    
    func viewProfile() {
        delegate?.viewProfile()
    }
    
    func logout() {
        delegate?.logout()
    }
}

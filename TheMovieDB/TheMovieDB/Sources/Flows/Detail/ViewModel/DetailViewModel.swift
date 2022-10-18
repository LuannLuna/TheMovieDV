//
//  DetailViewModel.swift
//  TheMovieDB
//
//  Created by Luann Luna on 15/10/22.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func showAllSeasons(tvShowId: Int, seasons: [Season])
}

class DetailViewModel: ObservableObject {
    
    @Published var tvShowDetail: TVShowDetailModel?
    @Published var isLoading: Bool = false
    
    let tvShow: TVModel
    var dataStore: DetailDataStore
    weak var delegate: DetailViewModelDelegate?
    
    init(tvShow: TVModel, dataStore: DetailDataStore) {
        self.dataStore = dataStore
        self.tvShow = tvShow
    }
    
    @MainActor
    func requestTvShow() async {
        isLoading = true
        defer { isLoading = false }
        guard let id = tvShow.id else { return }
        let query: TVQuery = .detail(id: id)
        let result = try? await dataStore.loadTvShowDetail(query: query)
        self.tvShowDetail = result
    }
}

extension DetailViewModel: LastSessonViewDelegate {
    func primaryButtonTapped() {
        guard let seasons = tvShowDetail?.seasons, let id = tvShowDetail?.id else { return }
        delegate?.showAllSeasons(tvShowId: id, seasons: seasons)
    }
}

// MARK: Extension of TVShow to facilitate UI update
extension TVShowDetailModel {
    var title: String {
        let last = seasons.sorted { $0.seasonNumber < $1.seasonNumber }.last
        return last?.name ?? ""
    }
    
    var subtitle: String {
        let last = seasons.sorted { $0.seasonNumber < $1.seasonNumber }.last
        return (last?.airDate.dateFormatted(format: "MMM dd, yyyy") ?? "").capitalized
    }
    
    var image: String {
        let last = seasons.sorted { $0.seasonNumber < $1.seasonNumber }.last
        return last?.posterPath ?? ""
    }
}

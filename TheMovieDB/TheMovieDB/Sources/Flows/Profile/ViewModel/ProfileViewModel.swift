//
//  ProfileViewModel.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation
import SwiftUI

class ProfileViewModel {
    let dataStore: ProfileDataStore
    @AppStorage(Keys.requestToken) private var requestToken: String = ""
    @AppStorage(Keys.sessionId) private var sessionId: String = ""
    @AppStorage(Keys.accoundId) private var accoundId: Int = 0
    
    
    @Published var tvs: [TVModel]
    @Published var isLoading: Bool = false
    
    @Published var account: AccountModel?
    
    weak var view: ProfileViewControllerDelegate?
    
    init(dataStore: ProfileDataStore) {
        self.dataStore = dataStore
        self.tvs = []
    }
    
    @MainActor
    func fetchWatchListData() async {
        isLoading = true
        defer { isLoading = false }
        let result = try? await dataStore.loadWatchList(accountId: accoundId, sessionId: sessionId)
        self.tvs = result ?? []
        self.view?.updateWatchList(watchList: tvs)
    }
    
    @MainActor
    func loadAccountDetail() async {
        isLoading = true
        defer {
            isLoading = false
            if let account = account {
                self.view?.updateAccount(account: account)
            }
        }
        let result = try? await dataStore.loadAccountDetail(sessionId: sessionId)
        self.account = result
        self.accoundId = result?.id ?? 0
    }
}

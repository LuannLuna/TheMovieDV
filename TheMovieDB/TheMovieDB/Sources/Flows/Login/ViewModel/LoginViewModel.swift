//
//  LoginViewModel.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import SwiftUI

protocol LoginViewModelDelegate: AnyObject {
    func showHomeView()
}

class LoginViewModel: ObservableObject {
    
    @AppStorage(Keys.requestToken) private var requestToken: String = ""
    @AppStorage(Keys.sessionId) private var sessionId: String = ""
    
    var username: String = ""
    var password: String = ""
    weak var delegate: LoginViewModelDelegate?
    let dataStore: LoginDataStore
    
    @Published var isLoading: Bool = false
    
    init(dataStore: LoginDataStore) {
        self.dataStore = dataStore
    }
    
    @MainActor
    func viewDidLoad() async {
        guard let result = try? await dataStore.generateToken() else { return }
        requestToken = result
    }
    
    @MainActor
    func login() async {
        isLoading = true
        defer { isLoading = false }
        
        let result = try? await dataStore.validateToken(username: username, password: password, oldToken: requestToken)
        if let success = result?.success, success, let newToken = result?.requestToken {
            guard let sessionId = try? await dataStore.generateSessionId(token: requestToken) else { return }
            self.sessionId = sessionId
            requestToken = newToken
            delegate?.showHomeView()
        }
    }
}

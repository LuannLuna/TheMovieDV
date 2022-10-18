//
//  MainCoordinator.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import SwiftUI
import UIKit

final class MainCoordinator: ObservableObject {

    private let window: UIWindow
    private var navigationController: UINavigationController?
    @AppStorage(Keys.requestToken) private var requestToken: String = ""
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func showRootView() {
        let hostingView: UIHostingController<AnyView>
        if requestToken.isEmpty {
            hostingView = UIHostingController(rootView: createLoginView())
        } else {
            hostingView = UIHostingController(rootView: createHomeView())
        }
        navigationController = UINavigationController(rootViewController: hostingView)
        navigationController?.navigationBar.prefersLargeTitles = true
        window.rootViewController = navigationController
    }
    
    private func createLoginView() -> AnyView {
        let dataStore = LoginDataStoreImpl(loginService: AuthenticationService())
        let viewModel = LoginViewModel(dataStore: dataStore)
        viewModel.delegate = self
        let swiftView = LoginView()
            .environmentObject(viewModel)
        return AnyView(swiftView)
    }
}

extension MainCoordinator: LoginViewModelDelegate {
    func showHomeView() {
        let hostingView = UIHostingController(rootView: createHomeView())
        navigationController?.setViewControllers([hostingView], animated: true)
    }
    
    private func createHomeView() -> AnyView {
        let dataStore = HomeDataStoreImpl(tvService: TVService())
        let viewModel = HomeViewModel(dataStore: dataStore)
        viewModel.delegate = self
        let swiftView = HomeView()
            .environmentObject(viewModel)
        return AnyView(swiftView)
    }
}

extension MainCoordinator: HomeViewModelDelegate {
    func showSelected(_ tvShow: TVModel) {
        let dataStore = DetailDataStoreImpl(tvService: TVService())
        let viewModel = DetailViewModel(tvShow: tvShow, dataStore: dataStore)
        viewModel.delegate = self
        let view = DetailView()
            .environmentObject(viewModel)
        let hostingView = UIHostingController(rootView: view)
        navigationController?.pushViewController(hostingView, animated: true)
    }
    
    func logout() {
        requestToken = ""
        let hostingView = UIHostingController(rootView: createLoginView())
        navigationController?.setViewControllers([hostingView], animated: true)
    }
    
    func viewProfile() {
        let dataStore = ProfileDataStoreImpl(watchListService: WatchListService())
        let viewModel = ProfileViewModel(dataStore: dataStore)
        let view = ProfileViewController()
        viewModel.view = view
        view.setupViewModel(viewModel: viewModel)
        navigationController?.present(view, animated: true)
    }
}

extension MainCoordinator: DetailViewModelDelegate {
    func showAllSeasons(tvShowId: Int, seasons: [Season]) {
        let dataStore = SeasonsDataStoreImpl(tvShowId: tvShowId, seasonService: SeasonService())
        let viewModel = SeasonsViewModel(seasons: seasons, dataStore: dataStore)
        let view = SeasonsView()
            .environmentObject(viewModel)
        let hostingView = UIHostingController(rootView: view)
        navigationController?.present(hostingView, animated: true)
    }
}

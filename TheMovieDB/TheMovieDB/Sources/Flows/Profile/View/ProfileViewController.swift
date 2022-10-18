//
//  ProfileViewController.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import UIKit
import SwiftUI

protocol ProfileViewControllerDelegate: AnyObject {
    func updateAccount(account: AccountModel)
    func updateWatchList(watchList: [TVModel])
}

class ProfileViewController: UIViewController {
    
    weak var profileView: ProfileViewProtocol?
    var viewModel: ProfileViewModel? {
        didSet {
            Task {
                await viewModel?.loadAccountDetail()
            }
        }
    }
    
    override func loadView() {
        let profileView = ProfileView()
        self.profileView = profileView
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    func setupViewModel(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
}

extension ProfileViewController: ProfileViewControllerDelegate {
    func updateAccount(account: AccountModel) {
        profileView?.setAccountDetail(account: account)
        Task {
            await viewModel?.fetchWatchListData()
        }
    }
    
    func updateWatchList(watchList: [TVModel]) {
        profileView?.setCarousel(watchList: watchList)
    }
}

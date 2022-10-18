//
//  ProfileView.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import Combine
import SwiftUI
import UIKit

protocol ProfileViewProtocol: AnyObject {
    func setAccountDetail(account: AccountModel)
    func setCarousel(watchList: [TVModel])
}

class ProfileView: UIView, ProfileViewProtocol {

    var cancellable: AnyCancellable?
    @ObservedObject var imageLoader = ImageLoader()
    
    private lazy var vStack = UIStackView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 20
        $0.distribution = .fill
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 10)
    }
    
    private lazy var title = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Profile"
        $0.textColor = UIColor(Color.tertiaryColor)
        $0.font = UIFont.boldSystemFont(ofSize: 24.0)
    }
    
    private lazy var hStack = UIStackView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 33
        $0.alignment = .center
        $0.distribution = .fill
        $0.isLayoutMarginsRelativeArrangement = true
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private lazy var imageView = UIImageView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.widthAnchor.constraint(equalToConstant: 125).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 125).isActive = true
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 62.5
    }
    
    private lazy var subVStack = UIStackView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    private lazy var name = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 18.0)
    }
    
    private lazy var userName = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = UIColor(Color.tertiaryColor)
        $0.font = UIFont.boldSystemFont(ofSize: 12.0)
    }
    
    private lazy var favoriteLabel = UILabel().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Favorite Shows"
        $0.textColor = UIColor(Color.tertiaryColor)
        $0.font = UIFont.boldSystemFont(ofSize: 18.0)
    }
    
    private lazy var emptyView = UIView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAccountDetail(account: AccountModel) {
        name.text = account.name
        userName.text = account.username
        guard let url = account.avatar?.gravatar?.urlImage else { return }
        self.imageLoader.loadImage(url: url)
        cancellable = imageLoader.$downloadedData.sink { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }
    }
    
    func setCarousel(watchList: [TVModel]) {
        let controller = UIHostingController(rootView: WatchListCarousel(watchList: watchList))
        controller.view.backgroundColor = .clear
        vStack.addArrangedSubview(favoriteLabel)
        vStack.addArrangedSubview(controller.view)
        vStack.addArrangedSubview(emptyView)
    }
}

extension ProfileView: ViewCodable {
    func setupViews() {
        
        addSubview(vStack)
        
        vStack.addArrangedSubview(title)
        vStack.addArrangedSubview(hStack)
        
        hStack.addArrangedSubview(imageView)
        hStack.addArrangedSubview(subVStack)
        
        subVStack.addArrangedSubview(name)
        subVStack.addArrangedSubview(userName)
        
        vStack.addArrangedSubview(emptyView)
    }
    
    func setupAnchors() {
        vStack.bindFrameToSuperviewBounds()
    }
}

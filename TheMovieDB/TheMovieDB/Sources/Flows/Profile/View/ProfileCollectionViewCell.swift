//
//  ProfileCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Luann Luna on 17/10/22.
//

import SwiftUI
import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    var tvModel: TVModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with tvModel: TVModel) {
        self.tvModel = tvModel
    }
}

extension ProfileCollectionViewCell: ViewCodable {
    func setupViews() {
        guard let tvModel = tvModel else { return }
        self.contentConfiguration = UIHostingConfiguration {
            HomeCarouselCard(tvShow: tvModel)
        }
    }
    
    func setupAnchors() {
        
    }
}

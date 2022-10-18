//
//  ViewCodable.swift
//  TheMovieDB
//
//  Created by Luann Luna on 15/10/22.
//

import Foundation

protocol ViewCodable {
    func setup()
    func setupViews()
    func setupAnchors()
    func setupLayouts()
}

extension ViewCodable {

    func setup() {
        setupViews()
        setupAnchors()
        setupLayouts()
    }
    
    func setupLayouts() {}

}


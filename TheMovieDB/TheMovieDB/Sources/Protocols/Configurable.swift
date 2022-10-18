//
//  File.swift
//  TheMovieDB
//
//  Created by Luann Luna on 15/10/22.
//

import Foundation

public protocol Configurable { }

public extension Configurable {
    
    func with(_ configure: (inout Self) -> Void) -> Self {
        var this = self
        configure(&this)
        return this
    }
}

extension NSObject: Configurable { }

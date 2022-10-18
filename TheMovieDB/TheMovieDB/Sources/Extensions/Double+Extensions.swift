//
//  Double+Extensions.swift
//  TheMovieDB
//
//  Created by Luann Luna on 15/10/22.
//

import Foundation

extension Double {
    func toString(formmat: String = "%.1f") -> String {
        return String(format: formmat, self)
    }
}

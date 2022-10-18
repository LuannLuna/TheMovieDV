//
//  String+Extensions.swift
//  TheMovieDB
//
//  Created by Luann Luna on 15/10/22.
//

import Foundation

extension String {
    func dateFormatted(format: String = "MMM dd, yyyy") -> String {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormmater.date(from: self) else { return "" }
        dateFormmater.dateFormat = format
        return dateFormmater.string(from: date)
    }
}

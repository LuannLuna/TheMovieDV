//
//  LocalFileJSON.swift
//  TheMovieDBTests
//
//  Created by Luann Luna on 17/10/22.
//

import Foundation

@testable import TheMovieDB

public class LocalFileJSON {
    
    public static func get<T: Decodable>(_ fileName: String) -> T {
        
        let bundle = Bundle(for: self)
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            fatalError("The resource named: \(fileName).json was not found!")
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            
            guard let data = try? Data(contentsOf: url, options: .mappedIfSafe) else {
                fatalError("Fail getting data information from \(url)")
            }
            
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch let error {
                fatalError("Cannot parser the \(T.self) object! \(error.localizedDescription)")
            }
        }
        
    }
    
}


//
//  NetworkProtocol.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

public protocol NetworkProtocolType {
    typealias NetworkCompletion<T> = (Result<T, NetworkError>) -> Void

    func call<T: RestQuery, U: Decodable>(_ query: T,
                                          _ decodable: U.Type,
                                          _ completion: @escaping NetworkCompletion<U>)
}


protocol NetworkProtocol: AnyObject, NetworkProtocolType {

    static var shared: NetworkProtocolType { get }
    var endpoint: URL? { get }
    var session: URLSession? { get }
    
}

extension NetworkProtocol {

    func handle<U: Decodable>(_ data: Data?,
                              _ error: Error?) -> Result<U, NetworkError> {
        
        if let error = error {
            return .failure(.detail(error.localizedDescription))
        }
        
        guard let data = data else {
            return .failure(.dataNotFound)
        }
        
        do {
            let decoded = try JSONDecoder().decode(U.self, from: data)
            return .success(decoded)
        } catch let decodeError {
            return .failure(.decodeFailure(decodeError.localizedDescription))
        }

    }

}

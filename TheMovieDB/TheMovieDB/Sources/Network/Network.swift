//
//  Network.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

public final class Network: NetworkProtocol {
    
    var endpoint: URL? { URL(string: baseURL) }
    var session: URLSession?
    
    public static var shared: NetworkProtocolType = Network()
    
    internal lazy var sessionRest: URLSession? = {
        let client = URLSession(configuration: .default)
        return client
    }()
    
    public func call<T: RestQuery, U: Decodable>(_ query: T,
                                                 _ decodable: U.Type,
                                                 _ completion: @escaping NetworkCompletion<U>) {
        
        guard let endpoint = endpoint else { return }
        
        var urlRequest = query.asURLRequest(endpoint.appendingPathParameters(["api_key": apiKey]))
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        sessionRest?.dataTask(with: urlRequest) { data, _, error in
            completion(self.handle(data, error))
        }.resume()
    }
}

//
//  RestQuery.swift
//  TheMovieDB
//
//  Created by Luann Luna on 14/10/22.
//

import Foundation

public protocol RestQuery {
    var path: String { get }
    var method: NetworkMethod { get }
    var parameters: [String: String]? { get }
    var body: [String: Any]? { get }
}

extension RestQuery {

    public var parameters: [String: String]? { nil }
    
    public var body: [String: Any]? { nil }
    
    public func asURLRequest(_ endpoint: URL) -> URLRequest {

        let url = endpoint
            .appendingPathComponent(path)
            .appendingPathParameters(parameters)

        let urlRequest = URLRequest(url: url)
            .appendingHttpMethod(method)
            .appendingHttpBody(body)

        return urlRequest

    }
    
    public func asURLRequest() -> URLRequest? {
        let urlFromPath = URL(string: path)
        guard var url = urlFromPath else { return nil }
        url = url.appendingPathParameters(parameters)

        let urlRequest = URLRequest(url: url)
            .appendingHttpMethod(method)
            .appendingHttpBody(body)

        return urlRequest
    }
}

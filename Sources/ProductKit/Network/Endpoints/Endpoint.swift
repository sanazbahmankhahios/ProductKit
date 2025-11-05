//
//  Endpoint.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var parameters: RequestParameters? { get }
}

public extension Endpoint {
    var baseURL: URL { URL(string: "https://dummyjson.com")! }
    var method: String { "GET" }
    var headers: [String: String]? { nil }
    var parameters: RequestParameters? { nil }

    func asURLRequest() throws -> URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method

        headers?.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        if let parameters {
            try request.encode(parameter: parameters)
        }

        return request
    }
}

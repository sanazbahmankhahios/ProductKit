//
//  RequestParameters.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation

public enum RequestParameters {
    case encodable(Encodable, encoder: JSONEncoder = JSONEncoder())
    case queryParameter(Encodable, encoder: JSONEncoder = JSONEncoder())
}

public extension URLRequest {
    mutating func encode(parameter: RequestParameters) throws {
        switch parameter {
        case let .encodable(encodable, encoder):
            try encode(encodable: encodable, encoder: encoder)
        case let .queryParameter(encodable, encoder):
            try queryParameter(encodable: encodable, encoder: encoder)
        }
    }

    private mutating func encode<V: Encodable>(encodable: V, encoder: JSONEncoder = JSONEncoder()) throws {
        httpBody = try encoder.encode(encodable)
        setValue("application/json", forHTTPHeaderField: "Content-Type")
    }

    private mutating func queryParameter<V: Encodable>(encodable: V, encoder: JSONEncoder = JSONEncoder()) throws {
        let data = try encoder.encode(encodable)
        guard let parameters = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw RequestParameterEncodingError.queryParameterEncodingFailure
        }

        guard let url = self.url else { throw URLError(.badURL) }
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = parameters.map { key, value in
            URLQueryItem(
                name: key,
                value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            )
        }
        
        if let urlWithQuery = urlComponents?.url {
            self.url = urlWithQuery
        }
    }
}

public enum RequestParameterEncodingError: Error {
    case queryParameterEncodingFailure
}

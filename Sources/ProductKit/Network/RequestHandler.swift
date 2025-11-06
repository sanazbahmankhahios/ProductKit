//
//  RequestHandler.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//

import Foundation
import Combine

public final class RequestHandler: @unchecked Sendable {
    private let session: URLSession
    public static let shared = RequestHandler()
      
      public init(session: URLSession = .shared) {
          self.session = session
      }

    public func call<T: Decodable>(_ endpoint: ProductEndpoint) -> AnyPublisher<T, Error> {
        do {
            let request = try endpoint.asURLRequest()
            return session.dataTaskPublisher(for: request)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse,
                          200..<300 ~= httpResponse.statusCode else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

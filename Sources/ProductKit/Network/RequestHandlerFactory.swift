//
//  RequestHandlerFactory.swift
//  ProductKit
//
//  Created by sanaz on 11/4/25.
//
import Foundation

public struct RequestHandlerFactory {
    public static func makeHandler(session: URLSession = .shared) -> RequestHandler {
        return RequestHandler(session: session)
    }
}

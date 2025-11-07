//
//  ProductCacheManager.swift
//  ProductModule
//
//  Created by sanaz on 11/6/25.
//
import Foundation

public protocol CacheLayer {
    func save<T: Codable>(value: T)
    func load<T: Codable>() -> T?
    func clear()
}

public final class DefaultCacheManager: CacheLayer {
    private let cacheURL: URL
    
    public init(filename: String) {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheURL = directory.appendingPathComponent(filename)
    }
    
    public func save<T: Codable>(value: T) {
        do {
            let data = try JSONEncoder().encode(value)
            try data.write(to: cacheURL, options: [.atomic])
        } catch {
            print("Failed to save cache:", error)
        }
    }
    
    public func load<T: Codable>() -> T? {
        do {
            let data = try Data(contentsOf: cacheURL)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
           return nil
        }
    }
    
    public func clear() {
        try? FileManager.default.removeItem(at: cacheURL)
    }
}

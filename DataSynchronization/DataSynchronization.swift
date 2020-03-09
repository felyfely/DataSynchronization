//
//  DataSynchronization.swift
//  miniGallery
//
//  Created by 付 旦 on 3/9/20.
//  Copyright © 2020 付 旦. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public protocol DataRequestable {
    var method: HTTPMethod { get }
    var host: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
}

public extension DataRequestable {
    
    var method: HTTPMethod { return .get }
    var parameters: [String: Any]? { return nil }

    func request<T: Decodable>(completionHandler: @escaping (Result<T, Error>) -> Void) {
        guard let baseUrl = URL.init(string: host) else {
            completionHandler(.failure(CustomError.init(description: "invalid host")))
            return
        }
        let requestUrl = baseUrl.appendingPathComponent(path)
        URLSession.shared.dataTask(with: requestUrl) { (data, _, error) in
            if let data = data {
                do {
                    // Convert the data to JSON
                    let object = try JSONDecoder.init().decode(T.self, from: data)
                    completionHandler(.success(object))

                } catch let error as NSError {
                    completionHandler(.failure(error))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}

struct CustomError: LocalizedError {
    let description: String
    var errorDescription: String? {
        return description
    }
}

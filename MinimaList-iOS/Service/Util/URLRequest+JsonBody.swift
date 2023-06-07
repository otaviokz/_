//
//  URLRequest+JsonBody.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import Foundation

extension URLRequest {
    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
    }
    
    static func get(_ url: URL) throws -> URLRequest {
        try request(httpMethod: .GET, url: url)
    }
    
    static func post(_ url: URL, body: Encodable) throws -> URLRequest {
        try request(httpMethod: .POST, url: url, body: body)
    }
    
    static func delete(_ url: URL, body: Encodable) throws -> URLRequest {
        try request(httpMethod: .DELETE, url: url, body: body)
    }
    
    static func request(httpMethod: HTTPMethod, url: URL, body: Encodable? = nil) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.cachePolicy  = .reloadIgnoringLocalCacheData
        if httpMethod != .GET, let body = body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return request
    }
}

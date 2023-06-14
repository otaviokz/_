//
//  MinimaListsServiceable.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import Foundation

protocol MinimaListsServiceable {
    var domainURL: URL { get }
    var endpoint: String { get }
    var endpointURL: URL { get }
    var session: URLSession { get }
    func handleUrlResponse(_ response: URLResponse) throws
}

extension MinimaListsServiceable {
    var session: URLSession { URLSession.shared }
        var domainURL: URL { URL(string: "https://lean-shopping-list.herokuapp.com")! }
//    var domainURL: URL { URL(string: "http://192.168.0.15:5001")! }
    var endpointURL: URL { domainURL.appendingPathComponent(endpoint) }
    
    func handleUrlResponse(_ response: URLResponse) throws {
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw ServiceError.unknown
        }
        guard code == 200 else { throw ServiceError.httpError(code: code) }
        return
    }
}

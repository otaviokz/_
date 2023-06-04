//
//  JsonLoader.swift
//  MinimaList-iOSTests
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import Foundation
@testable import MinimaLists_iOS

class JsonLoader {
    static func loadJson<T: Decodable>(_ filename: String) throws -> T {
        guard let file = Bundle(for: Self.self).url(forResource: filename, withExtension: "json") else {
            fatalError("Couldn't find \(filename) in test bundle.")
        }
        
        return try JSONDecoder().decode(T.self, from: try Data(contentsOf: file))
    }
    
    static func groceryItems() throws -> [ListItem] {
        try loadJson("Groceries")
    }
    
    static func leanLists() throws -> [LeanList] {
        try loadJson("LeanLists")
    }
}


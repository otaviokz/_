//
//  ItemsServiceable.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import Foundation

protocol ItemsServiceable: MinimaListsServiceable {
    func fetchItems() async throws -> [ListItem]
    func addItem(_ item: ListItem) async throws -> Bool
    func removeItem(_ item: ListItem) async throws -> Bool
}

extension ItemsServiceable {
    var endpoint: String { "items" }
}

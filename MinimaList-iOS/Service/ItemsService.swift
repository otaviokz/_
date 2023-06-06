//
//  ItemsService.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import Foundation

class ItemsService: ItemsServiceable {
    private var listItemsURL: URL { domainURL.appendingPathComponent("show/items") }
    private let selecteList: LeanList
    
    init(selectedList: LeanList) {
        self.selecteList = selectedList
    }
    
    func fetchItems() async throws -> [ListItem] {
        let (data, response) = try await session.data(for: .get(listItemsURL.appendingPathComponent(selecteList.name)))
        try handleUrlResponse(response)
        let items = try JSONDecoder().decode([ListItem].self, from: data)
        return items.sortedByName
    }
    
    func addItem(_ item: ListItem) async throws -> Bool {
        let (_, response) = try await session.data(for: .post(endpointURL, body: item))
        try handleUrlResponse(response)
        return true
    }
    
    func removeItem(_ item: ListItem) async throws -> Bool {
        let (_, response) = try await session.data(for: .delete(endpointURL, body: item))
        try handleUrlResponse(response)
        return true
    }
}

//
//  ListsService.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import Foundation

class ListsService: ListsServiceable {
//    @MainActor
    func fetchLists() async throws -> [LeanList] {
        let (data, response) = try await session.data(for: .get(endpointURL))
        try handleUrlResponse(response)
        let lists = try JSONDecoder().decode([LeanList].self, from: data)
        return lists.sortedByName
    }
    
    func addList(_ list: LeanList) async throws -> Bool {
        let (_, response) = try await session.data(for: .post(endpointURL, body: list))
        try handleUrlResponse(response)
        return true
    }
    
    func removeList(_ list: LeanList) async throws  -> Bool {
        let (_, response) = try await session.data(for: .delete(endpointURL, body: list))
        try handleUrlResponse(response)
        return true
    }
}

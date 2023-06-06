//
//  ListsServiceable.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import Foundation

protocol ListsServiceable: MinimaListsServiceable {
    func fetchLists() async throws -> [LeanList]
    func addList(_ list: LeanList) async throws -> Bool
    func removeList(_ list: LeanList) async throws -> Bool
}

extension ListsServiceable {
    var endpoint: String { "lists" }
}

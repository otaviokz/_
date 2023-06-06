//
//  ListsViewModel.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import Foundation

class ListsViewModel: ListsViewModelType {
    @Published private(set) var lists: [LeanList] = []
    @Published private(set) var isLoading = false
    var unavailableNames: [String] {
        lists.map { $0.name.lowercased() }
    }
    private var shouldFetchLists = true
    
    func onAppear() {
        fetchLists()
    }
    
    func fetchLists() {
        if shouldFetchLists {
            shouldFetchLists = false
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
                lists = mockLists
                isLoading = false
            }
        }
    }
    
    func createList(_ name: String, footNote: String?) {
        var aux = lists
        aux.append(LeanList(name, footNote: footNote))
        lists = aux.sortedByName
    }
    
    func remove(at indexSet: IndexSet) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            if let index = indexSet.first {
                lists.remove(at: index)
            }
            isLoading = false
        }
    }
}

private extension ListsViewModel {
    var mockLists: [LeanList] {
        [
            LeanList("Groceries", footNote: "Try Farmers Market first"),
            LeanList("High Street Shopping"),
            LeanList("SwiftUI & Combine: Main Chapters", footNote: "TW Tech Assessment! Don't panic, you'll sus it just like you always do. You'r a bloody good dev!"),
            LeanList("Tech Debts MinimaLists", footNote: "App is a bit clunky"),
            LeanList("Movies"),
        ]
    }
}

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

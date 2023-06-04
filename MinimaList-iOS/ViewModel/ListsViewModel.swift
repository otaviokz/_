//
//  ListsViewModel.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import Foundation

class ListsViewModel: ListsViewModelType {
    @Published private(set)var lists: [LeanList] = []
    @Published private(set)var isLoadingLists: Bool = false
    private var shouldFetchLists = true
    
    func onAppear() {
        fetchLists()
    }
    
    func fetchLists() {
        if shouldFetchLists {
            shouldFetchLists = false
            isLoadingLists = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [unowned self] in
                lists = Self.mockLists
                isLoadingLists = false
            }
        }
    }
}

private extension ListsViewModel {
    static var mockLists: [LeanList] {
        [
            LeanList("Groceries", footNote: "Try Farmers Market first"),
            LeanList("High Street Shopping"),
            LeanList("SwiftUI & Combine: Main Chapters", footNote: "TW Tech Assessment! Don't panic, you'll sus it just like you always do. You'r a bloody good dev!"),
            LeanList("Tech Debts MinimaLists", footNote: "App is a bit clunky"),
            LeanList("Movies"),
        ]
    }
}

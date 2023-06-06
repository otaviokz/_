//
//  PreviewListsViewModel.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import Foundation
import Combine

class PreviewListsViewModel: ListsViewModelType {
    var errorSubject = PassthroughSubject<ServiceError, Never>()
    
    var isLoading: Bool = false
    var unavailableNames: Set<String> {
        Set(lists.map { $0.name.dbKeyComparable })
    }
    private var shouldFetchLists = true
    
    var lists: [LeanList] = [
        LeanList("Groceries", footNote: "Try Farmers Market first"),
        LeanList("High Street Shopping"),
        LeanList("SwiftUI & Combine: Main Chapters", footNote: "TW Tech Assessment!"),
        LeanList("Tech Debts MinimaLists", footNote: "App is a bit clunky"),
        LeanList("Movies"),
    ]
    func fetchLists() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            lists = mockLists
            isLoading = false
        }

    }
    func onAppear() {
        if shouldFetchLists {
            shouldFetchLists = false
            fetchLists()
        }
    }
    func createList(_ name: String, footNote: String?) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
            lists = (lists + [LeanList(name, footNote: footNote)]).sortedByName
            isLoading = false
        }
        
    }
    func remove(at indexSet: IndexSet)  {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            if let index = indexSet.first {
                lists.remove(at: index)
            }
            isLoading = false
        }
    }
    
    func refresh() {}
}

private extension PreviewListsViewModel {
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

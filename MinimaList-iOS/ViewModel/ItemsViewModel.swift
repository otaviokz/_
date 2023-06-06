//
//  ItemsViewModel.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import Foundation

class ItemsViewModel: ItemsViewModelType {
    @Published private(set) var items: [ListItem] = []
    @Published private(set) var isLoading: Bool = false
    var unavailableNames: [String] {
        items.map { $0.name.lowercased() }
    }
    func onAppear(_ selectedList: LeanList) {
        fetchItems(for: selectedList.name)
    }
    
    func fetchItems(for listName: String) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            if listName == "Groceries" {
                items = mockItemsGroceries.sortedByName
            }
            isLoading = false
        }
    }
    
    func addItem(_ item: ListItem) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            items = (items + [item]).sortedByName
            isLoading = false
        }
    }
    
    func remove(at indexSet: IndexSet) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            if let index = indexSet.first {
                items.remove(at: index)
            }
            isLoading = false
        }
    }
}


private extension ItemsViewModel {
    var mockItemsGroceries: [ListItem] {
        [
            ListItem("Carrots", notes: "6 Big ones or 12 small ones", list: "Groceries"),
            ListItem("12 Eggs", list: "Groceries"),
            ListItem("Anchovies", notes: "The fresh ones, those canned are way too salty. The fresh ones, those canned are way too salty. The fresh ones, those canned are way too salty. The fresh ones, those canned are way too salty.", list: "Groceries"),
            ListItem("4 AA Batteries", list: "Groceries"),
            ListItem("Shampoo", notes: "Clean & Clear", list: "Groceries"),
            ListItem("Dove Soap", list: "Groceries")
        ]
    }
}

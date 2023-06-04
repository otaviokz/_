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
}


private extension ItemsViewModel {
    var mockItemsGroceries: [ListItem] {
        [
            ListItem("Carrots", notes: "6 Big ones or 12 small ones", list: "Groceries"),
            ListItem("12 Eggs", list: "Groceries"),
            ListItem("Anchovies", notes: "The fresh ones, those canned are way too salty.", list: "Groceries"),
            ListItem("4 AA Batteries", list: "Groceries"),
            ListItem("Shampoo", notes: "Clean & Clear", list: "Groceries"),
            ListItem("Dove Soap", list: "Groceries")
        ]
    }
}

//
//  PreviewItemsViewModel.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 05/06/2023.
//

import Foundation
import Combine

class PreviewItemsViewModel: ItemsViewModelType {
    @Published private(set) var items: [ListItem] = []
    @Published var isLoading: Bool = false
    var errorSubject = PassthroughSubject<ServiceError, Never>()
    var unavailableNames: Set<String> {
        Set(items.map { $0.name.dbKeyComparable })
    }
    var selectedList: LeanList
    private(set) var service: ItemsServiceable
    
    required init(selectedList: LeanList) {
        self.selectedList = selectedList
        self.service = ItemsService(selectedList: selectedList)
    }
    
    func onAppear() {
        fetchItems()
    }
    
    func refresh() {
        fetchItems()
    }
    
    func addItem(_ item: ListItem) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            items = (items + [item]).sortedByName
            isLoading = false
        }
    }
    
    func remove(at: IndexSet) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            if let index = at.first {
                items.remove(at: index)
                isLoading = false
            }
        }
    }
}


private extension PreviewItemsViewModel {
    func fetchItems() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            if selectedList.name == "Groceries" {
                items = mockItemsGroceries.sortedByName
            }
            isLoading = false
        }
    }
    
    var mockItemsGroceries: [ListItem] {
        [
            ListItem("Carrots", note: "6 Big ones or 12 small ones", list: "Groceries"),
            ListItem("12 Eggs", list: "Groceries"),
            ListItem("Anchovies", note: "The fresh ones, those canned are way too salty.", list: "Groceries"),
            ListItem("4 AA Batteries", list: "Groceries"),
            ListItem("Shampoo", note: "Clean & Clear", list: "Groceries"),
            ListItem("Dove Soap", list: "Groceries")
        ]
    }
}

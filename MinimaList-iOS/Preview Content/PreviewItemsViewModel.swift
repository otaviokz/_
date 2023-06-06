//
//  PreviewItemsViewModel.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 05/06/2023.
//

import Foundation

class PreviewItemsViewModel: ItemsViewModelType {
    @Published private(set) var items: [ListItem] = []
    @Published private(set) var isLoading: Bool = false
    var unavailableNames: [String] {
        items.map { $0.name.lowercased() }
    }
    
    func onAppear(_ selectedList: LeanList) {}
    func addItem(_ item: ListItem) {}
    func remove(at: IndexSet) {}
}

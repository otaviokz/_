//
//  ItemsViewModel.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import Foundation
import Combine
import SwiftUI

class ItemsViewModel: ItemsViewModelType {
    @MainActor @Published private(set) var items: [ListItem] = []
    @MainActor @Published var isLoading: Bool = false
    @MainActor @State private var loading = false {
        didSet {
            isLoading = loading
        }
    }
    private(set) var service: ItemsServiceable
    @MainActor var errorSubject = PassthroughSubject<ServiceError, Never>()
    private var selectedList: LeanList?
    
    init(service: ItemsServiceable = ItemsService()) {
        self.service = service
    }
    
    @MainActor
    var unavailableNames: Set<String> {
        Set(items.map { $0.name.dbKeyComparable })
    }
    
    @MainActor
    func onAppear(_ selectedList: LeanList) {
        self.selectedList = selectedList
        fetchItems(for: selectedList)
    }
    
    @MainActor
    func refresh() {
        if let list = selectedList {
            fetchItems(for: list)
        }
    }
    
    @MainActor
    func fetchItems(for list: LeanList) {
        isLoading = true
        runInTask { [unowned self] in
            items = try await service.fetchItems(for: list)
            isLoading = false
        }
    }
    
    @MainActor
    func addItem(_ item: ListItem) {
        isLoading = true
        runInTask { [unowned self] in
            if try await service.addItem(item) {
                fetchItems(for: LeanList(item.list))
            }
            isLoading = false
        }
    }
    
    @MainActor
    func remove(at indexSet: IndexSet) {
        if let index = indexSet.first {
            let item = items[index]
            isLoading = true
            runInTask { [unowned self] in
                if try await service.removeItem(item) {
                    fetchItems(for: LeanList(item.list))
                }
                isLoading = false
            }
        }
    }
}

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
    private(set) var service: ItemsServiceable
    @MainActor var errorSubject = PassthroughSubject<ServiceError, Never>()
    internal var selectedList: LeanList

    required init(selectedList: LeanList) {
        self.selectedList = selectedList
        self.service = ItemsService(selectedList: selectedList)
    }
    
    init(selecetList: LeanList, service: ItemsServiceable) {
        self.selectedList = selecetList
        self.service = service
    }
    
    @MainActor
    var unavailableNames: Set<String> {
        Set(items.map { $0.name.dbKeyComparable })
    }
    
    @MainActor
    func onAppear() {
        fetchItems(for: selectedList)
    }
    
    @MainActor
    func refresh() {
        fetchItems(for: selectedList)
    }
    
    @MainActor
    func fetchItems(for list: LeanList) {
        isLoading = true
        runInTask { [unowned self] in
            do {
                items = try await service.fetchItems()
                isLoading = false
            } catch let error {
                print(error)
                isLoading = false
            }            
        }
    }
    
    @MainActor
    func addItem(_ item: ListItem) {
        isLoading = true
        runInTask { [unowned self] in
            do {
                if try await service.addItem(item) {
                    fetchItems(for: LeanList(item.list))
                }
                isLoading = false
            } catch let error {
                print(error)
                isLoading = false
            }
        }
    }
    
    @MainActor
    func remove(at indexSet: IndexSet) {
        if let index = indexSet.first {
            let item = items[index]
            isLoading = true
            runInTask { [unowned self] in
                do {
                    if try await service.removeItem(item) {
                        fetchItems(for: LeanList(item.list))
                    }
                    isLoading = false
                } catch let error {
                    print(error)
                    isLoading = false
                }
            }
        }
    }
}

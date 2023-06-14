//
//  ListsViewModel.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import Foundation
import Combine
import SwiftUI

class ListsViewModel: ListsViewModelType {
    @MainActor @Published private(set) var lists: [LeanList] = []
    @MainActor @Published var isLoading = false
    private(set) var service: ListsServiceable
    @MainActor var errorSubject = PassthroughSubject<ServiceError, Never>()
    
    init(service: ListsServiceable = ListsService()) {
        self.service = service
    }
    
    @MainActor
    var unavailableNames: Set<String> {
        Set(lists.map { $0.name.dbKeyComparable })
    }
    private var shouldFetchLists = true
    
    @MainActor
    func refresh() {
        fetchLists()
    }
    
    @MainActor
    func onAppear() {
        if shouldFetchLists {
            fetchLists()
            shouldFetchLists = false
        }
    }
    
    @MainActor
    func fetchLists()  {
        isLoading = true
        runInTask { [unowned self] in
            do {
                lists = try await service.fetchLists()
                isLoading = false
            } catch let error {
                print(error)
                isLoading = false
            }
        }
    }
    
    @MainActor
    func createList(_ name: String, footNote: String?) {
        isLoading = true
        runInTask { [unowned self] in
            do {
                if try await service.addList(LeanList(name, footNote: footNote)) {
                    isLoading = false
                    fetchLists()
                }
            } catch let error {
                print(error)
                isLoading = false
            }
        }
    }
    
    @MainActor
    func remove(at indexSet: IndexSet) {
        if let index = indexSet.first {
            let list = lists[index]
            isLoading = true
            runInTask { [unowned self] in
                do {
                    if try await service.removeList(list) {
                        isLoading = false
                        fetchLists()
                    }
                } catch let error {
                    print(error)
                    isLoading = false
                }
            }
        }
    }
}

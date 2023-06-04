//
//  PreviewListsViewModel.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import Foundation

class PreviewListsViewModel: ListsViewModelType {
    var isLoading: Bool = false
    var lists: [LeanList] = [
        LeanList("Groceries", footNote: "Try Farmers Market first"),
        LeanList("High Street Shopping"),
        LeanList("SwiftUI & Combine: Main Chapters", footNote: "TW Tech Assessment!"),
        LeanList("Tech Debts MinimaLists", footNote: "App is a bit clunky"),
        LeanList("Movies"),
    ]
    
    func onAppear() {}
    
    init() {
        
    }
    
    func createList(_ name: String, footNote: String?) {}
}

class PreviewItemsViewModel: ItemsViewModelType {
    @Published private(set) var items: [ListItem] = []
    @Published private(set) var isLoading: Bool = false
    
    func onAppear(_ selectedList: LeanList) {}
}

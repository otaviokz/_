//
//  PreviewListsViewModel.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import Foundation

class PreviewListsViewModel: ListsViewModelType {
    var lists: [LeanList] = [
        LeanList("Groceries", footNote: "Try Farmers Market first"),
        LeanList("High Street Shopping"),
        LeanList("SwiftUI & Combine: Main Chapters", footNote: "TW Tech Assessment!"),
        LeanList("Tech Debts MinimaLists", footNote: "App is a bit clunky"),
        LeanList("Movies"),
    ]
    
    var isLoadingLists: Bool = false
    
    func onAppear() { }
}

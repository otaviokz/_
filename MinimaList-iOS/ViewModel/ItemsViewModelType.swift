//
//  ItemsViewModelType.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import Foundation

protocol ItemsViewModelType: ObservableObject {
    var items: [ListItem] { get }
    var isLoading: Bool { get }
    var unavailableNames: [String] { get }
    
    func onAppear(_ selectedList: LeanList)
    func addItem(_ item: ListItem)
    func remove(at: IndexSet)
}
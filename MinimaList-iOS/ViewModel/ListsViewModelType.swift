//
//  ListsViewModelType.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import Foundation


protocol ListsViewModelType: ObservableObject, ViewModelType {
    var lists: [LeanList] { get }
    var unavailableNames: Set<String> { get }
    
    func onAppear()
    func createList(_ name: String, footNote: String?)
    func remove(at indexSet: IndexSet) 
}


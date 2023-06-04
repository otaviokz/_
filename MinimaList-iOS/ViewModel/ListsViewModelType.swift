//
//  ListsViewModelType.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import Foundation


protocol ListsViewModelType: ObservableObject {
    var lists: [LeanList] { get }
    var isLoading: Bool { get }
    func onAppear()
    func createList(_ name: String, footNote: String?)
}

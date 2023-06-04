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
    
    func onAppear(_ selectedList: LeanList)
}

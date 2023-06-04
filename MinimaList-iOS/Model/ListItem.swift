//
//  ListItem.swift
//  MinimaList-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import Foundation

struct ListItem: Codable {
    let name: String
    let notes: String?
    let list: String
}


extension Array where Element == ListItem {
    var sortedByName: [ListItem] {
        sorted {
            $0.name < $1.name
        }
    }
}

//
//  ListItem.swift
//  MinimaList-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import Foundation

struct ListItem: Identifiable {
    let name: String
    let notes: String?
    let list: String
    let id = UUID()
    
    init(_ name: String, notes: String? = nil, list: String) {
        self.name = name
        self.notes = notes
        self.list = list
    }
}

extension ListItem: Codable {
    private enum CodingKeys: String, CodingKey {
        case name, notes, list
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        if let notes = self.notes, !notes.isEmpty {
            try container.encode(notes, forKey: .notes)
        } else {
            try container.encodeNil(forKey: .notes)
        }
        try container.encode(list, forKey: .list)
    }
}

extension ListItem: Comparable {
    static func < (lhs: ListItem, rhs: ListItem) -> Bool {
        lhs.name.lowercased() < rhs.name.lowercased()
    }
}

extension Array where Element == ListItem {
    var sortedByName: [ListItem] {
        sorted { $0.name < $1.name }
    }
}

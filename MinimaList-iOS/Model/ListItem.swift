//
//  ListItem.swift
//  MinimaList-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import Foundation

struct ListItem: Identifiable {
    let name: String
    let note: String?
    let list: String
    let id = UUID()
    
    init(_ name: String, note: String? = nil, list: String) {
        self.name = name
        self.note = note
        self.list = list
    }
}

extension ListItem: Codable {
    private enum CodingKeys: String, CodingKey {
        case name, note, list
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        if let note = self.note, !note.isEmpty {
            try container.encode(note, forKey: .note)
        } else {
            try container.encodeNil(forKey: .note)
        }
        try container.encode(list, forKey: .list)
    }
}

extension Array where Element == ListItem {
    var sortedByName: [ListItem] {
        sorted { $0.name.dbKeyComparable < $1.name.dbKeyComparable }
    }
}

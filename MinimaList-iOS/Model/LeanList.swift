//
//  LeanList.swift
//  MinimaList-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import Foundation

/*
 * I didn't call it simply "List" to avoid compiling problems
 * I decided on "Lean" simply because I thought MinimaList was cool as an App name, but awkward as a struc name
 */
struct LeanList: Identifiable {
    private(set) var name: String
    private(set) var footNote: String?
    let id = UUID()
    
    init(_ name: String, footNote: String? = nil) {
        self.name = name
        self.footNote = footNote
    }
}

extension LeanList: Codable {
    private enum CodingKeys: String, CodingKey {
        case name, footNote
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.footNote = try? values.decodeIfPresent(String.self, forKey: .footNote)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        if let footNote = self.footNote, !footNote.isEmpty {
            try container.encode(footNote, forKey: .footNote)
        } else {
            try container.encodeNil(forKey: .footNote)
        }
    }
}

extension Array where Element == LeanList {
    var sortedByName: [LeanList] {
        sorted { $0.name.dbKeyComparable < $1.name.dbKeyComparable }
    }
}

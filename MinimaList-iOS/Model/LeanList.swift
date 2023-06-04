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
struct LeanList: Codable {
    let name: String
}

extension Array where Element == LeanList {
    var sortedByName: [LeanList] {
        sorted { $0.name < $1.name }
    }
}

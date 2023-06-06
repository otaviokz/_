//
//  String+Utils.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import Foundation

extension String {
    var trimmingSpaces: String {
        trimmingCharacters(in: .whitespaces)
    }
    
    var dbKeyComparable: String {
        trimmingSpaces.lowercased()
    }
}

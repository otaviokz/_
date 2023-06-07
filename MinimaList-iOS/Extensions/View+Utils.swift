//
//  View+Utils.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import SwiftUI

extension View {
    @inlinable func identifier(_ identifier: String) -> some View {
        accessibility(identifier: identifier)
    }
    
    var isRunningTets: Bool {
        ProcessInfo().arguments.contains("testMode")
    }
}

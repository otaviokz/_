//
//  Button+Utils.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 20/06/2023.
//

import SwiftUI

extension Button {
    init(label: () -> Label, action: @escaping () -> Void) {
        self.init(action: action, label: label)
    }
}

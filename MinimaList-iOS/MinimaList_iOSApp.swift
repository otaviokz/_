//
//  MinimaList_iOSApp.swift
//  MinimaList-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import SwiftUI

@main
struct MinimaList_iOSApp: App {
    var body: some Scene {
        WindowGroup {
            ListsView(viewModel: ListsViewModel())
        }
    }
}

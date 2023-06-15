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
//            if isRunningTets {
//                ListsView(viewModel: PreviewListsViewModel())
//            } else {
                ListsView(viewModel: ListsViewModel())
//            }
            
        }
    }
    
    var isRunningTets: Bool {
        ProcessInfo().arguments.contains("testMode")
    }
}

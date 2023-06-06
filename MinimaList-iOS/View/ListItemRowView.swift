//
//  ListItemRowView.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import SwiftUI

struct ListItemRowView: View {
    private let item: ListItem
    private let onInfoTap: (String) -> Void
    
    init(_ item: ListItem, onInfoTap: @escaping (String) -> Void) {
        self.item = item
        self.onInfoTap = onInfoTap
    }
    
    var body: some View {
        HStack {
            Text(item.name)
                .font(.title3)
                .fontWeight(.semibold)
                .identifier(item.name)
            
            Spacer()
            
            if let notes = item.notes {
                Image(systemName: "info.circle")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        self.onInfoTap(notes)
                    }
                    .identifier("\(item.name).info.img")
            }
        }
    }
}

struct ListItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemRowView(ListItem("Bananas", notes: "Not the big ones", list: "Groceries")) { _ in }
    }
}
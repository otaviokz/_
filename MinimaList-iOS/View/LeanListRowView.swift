//
//  LeanListRowView.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import SwiftUI

struct LeanListRowView: View {
    let list: LeanList
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(list.name)
                    .font(.title3)
                    .fontWeight(.regular)
                Spacer()
            }
            
            if let footNote = list.footNote {
                HStack {
                    Text(footNote)
                        .font(.footnote)
                        .fontWeight(.regular)
                    Spacer()
                }
                .padding(.top, 4)                
            }
        }
        .frame(minHeight: 44)
    }
}

struct LeanListRowView_Previews: PreviewProvider {
    static var previews: some View {
        LeanListRowView(list: LeanList("Groceries", footNote: "Try Farmers Market First!s"))
    }
}

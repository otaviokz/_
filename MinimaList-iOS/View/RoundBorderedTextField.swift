//
//  RoundBorderedTextField.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import SwiftUI

struct RoundBorderedTextField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text)
            .frame(height: 40)
            .padding(.horizontal, 16)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 1)
            )
            .padding(.horizontal, 16)
            .identifier(title)
    }
}

//struct RoundBorderedTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        RoundBorderedTextField()
//    }
//}

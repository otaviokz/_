//
//  RoundBorderedTextField.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import SwiftUI

struct RoundBorderedTextField: View {
    private let title: String
    private let text: Binding<String>
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self.text = text
    }
    
    var body: some View {
        TextField(title, text: text)
            .frame(height: 40)
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .padding(.leading, 1)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 1)
            )
            .padding(.horizontal, 16)
            .identifier(title)
    }
}

struct RoundBorderedTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var text: String = ""
        return RoundBorderedTextField("Title", text: $text)
    }
}



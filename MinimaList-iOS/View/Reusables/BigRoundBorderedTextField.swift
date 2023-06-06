//
//  BigRoundBorderedTextField.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import SwiftUI

struct BigRoundBorderedTextField: View {
    let title: String
    let height: CGFloat
    let text: Binding<String>
    
    init(_ title: String, height: CGFloat, text: Binding<String>) {
        self.title = title
        self.height = height
        self.text = text
    }
    
    var body: some View {
        TextField(title, text: text, axis: .vertical)
            .frame(height: height, alignment: .topLeading)
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 1)
            )
            .padding(.horizontal, 16)
            .multilineTextAlignment(.leading)
            .truncationMode(.tail)
            .identifier(title)
    }
}

struct BigRoundBorderedTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var text = ""
        BigRoundBorderedTextField("BigRoundBorderedTextField", height: 140, text: $text)
    }
}

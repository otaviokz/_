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
    @Binding var text: String
    
    var body: some View {
        TextField(title, text: $text, axis: .vertical)
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

//struct BigRoundBorderedTextField_Previews: PreviewProvider {
//    @State var text = ""
//    static var previews: some View {
//        BigRoundBorderedTextField("BigRoundBorderedTextField", height: 140, text: $text)
//    }
//}

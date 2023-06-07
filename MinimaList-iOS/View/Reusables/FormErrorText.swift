//
//  FormErrorText.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import SwiftUI


struct FormErrorText: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.red)
                .font(.subheadline)
                .fontWeight(.regular)
                .identifier(text)
            Spacer()
        }
        .padding(.horizontal, 24)
        
    }
}


struct FormErrorText_Previews: PreviewProvider {
    static var previews: some View {
        FormErrorText(text: "Max 64 characters")
    }
}

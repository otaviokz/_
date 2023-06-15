//
//  SaveButton.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import SwiftUI

struct SaveButton: View {
    let action: () -> Void
    
    var body: some View {
        Button("Save", action: action)
            .foregroundColor(.blue)
            .font(.headline)
            .frame(width: 70, height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.blue, lineWidth: 2)
            )
            .padding(.leading, 16)
            .padding(.trailing, 1)
            .identifier("Save")
    }
}

struct SaveButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveButton() {}
    }
}

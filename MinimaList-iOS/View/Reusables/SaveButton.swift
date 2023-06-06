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
            .frame(width: 100, height:  38)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.blue, lineWidth: 2)
            )
            .padding()
            .identifier("Save")
    }
}

struct SaveButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveButton() {}
    }
}

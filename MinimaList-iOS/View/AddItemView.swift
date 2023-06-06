//
//  AddItemView.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 06/06/2023.
//

import SwiftUI

struct AddItemView: View {
    private let listName: String
    @State private var name = ""
    @State private var notes = ""
    private let unavailableNames: [String]
    @State private var nameAlreadyUsed = false
    private let onDismiss: () -> Void
    private let onAdd: (ListItem) -> Void
    @FocusState var focus: AddItemFocusElement?
    
    init(_ listName: String, unavailableNames: [String], onDismiss: @escaping () -> Void, onAdd: @escaping (ListItem) -> Void) {
        self.listName = listName
        self.unavailableNames = unavailableNames
        self.onDismiss = onDismiss
        self.onAdd = onAdd
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "x.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(24)
                    .onTapGesture {
                        onDismiss()
                    }
            }
            
            RoundBorderedTextField(title: "Name", text: $name)
                .keyboardType(.default)
                .focused($focus, equals: .name)
                .onSubmit {
                    focus = .note
                }
            
            if nameAlreadyUsed {
                FormErrorText(text: "Item \(name) already in this list.")
            } else if name.count > 64 {
                FormErrorText(text: "Max 64 characteres")
            }
            
            
            TextField("Notes", text: $notes, axis: .vertical)
                .keyboardType(.default)
                .frame(height: 200, alignment: .topLeading)
                .padding(.horizontal, 24)
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .keyboardType(.numberPad)
                .padding(.horizontal, 16)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .focused($focus, equals: .note)
            
            if notes.count > 256 {
                FormErrorText(text: "Max 256 characteres")
            }
            
            Spacer()
            if showButton {
                saveButton
            }
            
        }
        .onChange(of: $name) { _ in
            nameAlreadyUsed = unavailableNames.contains(name.lowercased())
        }
        .onAppear {
            focus = .name
        }
    }
    
    var saveButton: some View {
        Button("Save") {
            onAdd(
                ListItem(name, notes: notes.isEmpty ? nil : notes, list: listName)
            )
        }
        .foregroundColor(.blue)
        .font(.headline)
        .frame(width: 140, height:  38)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.blue, lineWidth: 2)
        )
        .padding()
    }
    
    var showButton: Bool {
        !nameAlreadyUsed && !name.isEmpty && name.count <= 64 && notes.count <= 256
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView("List", unavailableNames: [], onDismiss: {}) { item in }
    }
}

enum AddItemFocusElement: Hashable {
    case name
    case note
}

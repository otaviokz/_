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
    @State private var note = ""
    private let unavailableItemNames: Set<String>
    @State private var nameAlreadyUsed = false
    private let onDismiss: () -> Void
    private let onAdd: (ListItem) -> Void
    @FocusState var focus: AddItemFocusElement?
    
    init(_ listName: String, unavailableNames: Set<String>, onDismiss: @escaping () -> Void, onAdd: @escaping (ListItem) -> Void) {
        self.listName = listName
        self.unavailableItemNames = unavailableNames
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
                .focused($focus, equals: .name)
                .onSubmit {
                    focus = .note
                }
            
            if nameAlreadyUsed {
                FormErrorText(text: "Item \(name.trimmingSpaces) already in this list.")
            } else if name.trimmingSpaces.count > 64 {
                FormErrorText(text: "Max 64 characteres")
            }
            
            
            BigRoundBorderedTextField(title: "Notes", height: 200, text: $note)
                .focused($focus, equals: .note)    
            
            if note.trimmingSpaces.count > 256 {
                FormErrorText(text: "Max 256 characteres")
            }
            
            Spacer()
            if showSaveButton {
                SaveButton {
                    onAdd(
                        ListItem(
                            name.trimmingSpaces,
                            note: note.isEmpty ? nil : note,
                            list: listName
                        )
                    )
                }
            }
            
        }
        .onChange(of: $name) { _ in
            nameAlreadyUsed = unavailableItemNames.contains(name.dbKeyComparable)
        }
        .onAppear {
            focus = .name
        }
    }
    
    var showSaveButton: Bool {
        !nameAlreadyUsed && !name.isEmpty && name.count <= 64 && note.count <= 256
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

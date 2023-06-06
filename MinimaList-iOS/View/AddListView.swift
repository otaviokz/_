//
//  AddListView.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import SwiftUI

struct AddListView: View {
    @State private var name = ""
    @State private var footNote = ""
    @State private var nameAlreadyUsed: Bool = false
    @FocusState var focus: AddListFocusElement?
    
    let unavailableListNames: Set<String>
    let onDismiss: () -> Void
    let onAdd: (String, String?) -> Void

    init(unavailable: Set<String>, onDismiss: @escaping () -> Void, onAdd: @escaping (String, String?) -> Void) {
        self.unavailableListNames = unavailable
        self.onAdd = onAdd
        self.onDismiss = onDismiss
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
            
            // Mark: List name
            RoundBorderedTextField(title: "List name", text: $name)
                .focused($focus, equals: .name)
                .onSubmit {
                    focus = .footNote
                }
            
            if nameAlreadyUsed {
                FormErrorText(text: "\(name.trimmingSpaces) already used.")
            } else if name.trimmingSpaces.count > 64 {
                FormErrorText(text: "Max 64 characters")
            }
        
            BigRoundBorderedTextField(title: "Foot note", height: 100, text: $footNote)
                .focused($focus, equals: .footNote)
            
            if footNote.trimmingSpaces.count > 128 {
                FormErrorText(text: "Max 128 characters")
            }
            
            Spacer()
            
            // Mark: Save Buttpn
            if showSaveButton {
                SaveButton {
                    onAdd(
                        name.trimmingSpaces,
                        footNote.isEmpty ? nil : footNote
                    )
                }
            }
        }
        .onAppear {
            focus = .name
        }
        .onChange(of: $name) { _ in
            nameAlreadyUsed = unavailableListNames.contains(name.dbKeyComparable)
        }
    }
    
    var showSaveButton: Bool {
        !nameAlreadyUsed && !name.isEmpty && name.count <= 64 && footNote.count <= 128
    }
}

enum AddListFocusElement: Hashable {
    case name
    case footNote
}

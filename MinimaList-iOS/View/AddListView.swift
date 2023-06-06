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
    
    let unavailableListNames: [String]
    let onDismiss: () -> Void
    let onAdd: (String, String?) -> Void

    init(unavailable: [String], onDismiss: @escaping () -> Void, onAdd: @escaping (String, String?) -> Void) {
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
            TextField("List name", text: $name)
                .frame(height: 44)
                .padding(.horizontal, 24)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .padding(.horizontal, 16)
                .focused($focus, equals: .name)
                .identifier("List name")
                .onSubmit {
                    focus = .footNote
                }
            
            if nameAlreadyUsed {
                FormErrorText(text: "\(name) already used.")
            } else if name.count > 64 {
                FormErrorText(text: "Max 64 characters")
            }
        
            // Mark: List footNote
            TextField("Foot note", text: $footNote)
                .frame(height: 100, alignment: .topLeading)
                .padding(.horizontal, 24)
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .padding(.horizontal, 16)
                .multilineTextAlignment(.leading)
                .truncationMode(.tail)
                .focused($focus, equals: .footNote)
                .identifier("Foot note")
            
            if footNote.count > 128 {
                FormErrorText(text: "Max 128 characters")
            }
            
            Spacer()
            
            // Mark: Save Buttpn
            if presentSaveButton {
                saveButton
            }
        }
        .onAppear {
            focus = .name
        }
        .onChange(of: $name) { _ in
            nameAlreadyUsed = unavailableListNames.contains(name.lowercased())
        }
    }
    
    var presentSaveButton: Bool {
        !nameAlreadyUsed && !name.isEmpty && name.count <= 64 && footNote.count <= 128
    }
    
    var saveButton: some View {
        return Button("Save") {
            onAdd(name, footNote.isEmpty ? nil : footNote)
        }
        .foregroundColor(.blue)
        .accentColor(.secondary)
        .font(.headline)
        .frame(width: 140, height: 38, alignment: .center)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.blue, lineWidth: 1)
        )
        .padding()
        .identifier("Save")
    }
}

enum AddListFocusElement: Hashable {
    case name
    case footNote
}

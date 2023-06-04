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
    @State private var showNameUsedAlert: Bool = false
    @FocusState var focus: FocusElement?
    
    let unavailableListNames: [String]
    let onDismiss: () -> Void
    let onAdd: (String, String?) -> Void

    init(unavailableListNames: [String], onDismiss: @escaping () -> Void, onAdd: @escaping (String, String?) -> Void) {
        self.unavailableListNames = unavailableListNames
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
                    .onTapGesture {
                        onDismiss()
                    }
                    .padding(.vertical, 24)
                    .padding(.trailing, 24)
                    .foregroundColor(.blue)
                
            }
            TextField("List name", text: $name)
                .frame(height: 44)
                .padding(.horizontal, 24)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .padding(.horizontal, 16)
                .onSubmit {
                    focus = FocusElement.footNote
                }
                .focused($focus, equals: FocusElement.name)
                .accessibility(identifier: "List name")
            
            if nameAlreadyUsed {
                HStack {
                    Text("\(name) already used.")
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .accessibilityIdentifier("Name already used")
                    Spacer()
                }
                .padding(.horizontal, 16)
            } else if name.count > 64 {
                HStack {
                    Text("Max 64 characters")
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .fontWeight(.regular)
                    Spacer()
                }
            }
            
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
                .focused($focus, equals: FocusElement.footNote)
                .accessibility(identifier: "Foot note")
            
            if footNote.count > 128 {
                HStack {
                    Text("Max 128 characters")
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .fontWeight(.regular)
                    Spacer()
                }
            }
            
            Spacer()
            
            if showButton {
                saveButton
                    .accessibility(identifier: "Save")
            }
        }
        .onAppear {
            focus = FocusElement.name
        }
        .onChange(of: $name) { _ in
            nameAlreadyUsed = unavailableListNames.contains(name.lowercased())
        }
        .alert(isPresented: $showNameUsedAlert) {
            Alert(
                title: Text("Woops"),
                message: Text("List name unavailable."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    var showButton: Bool {
        !nameAlreadyUsed && !name.isEmpty && name.count <= 64 && footNote.count <= 128
    }
    
    var saveButton: some View {
        return Button("Save") {
            if unavailableListNames.contains(name.lowercased()) {
                showNameUsedAlert = true
            }
            else {
                onAdd(name, footNote.isEmpty ? nil : footNote)
            }
        }
        .font(.headline)
        .frame(width: 140, height: 38, alignment: .center)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.blue, lineWidth: 2)
        )
        .padding()
    }
}

enum FocusElement: Hashable {
    case name
    case footNote
}

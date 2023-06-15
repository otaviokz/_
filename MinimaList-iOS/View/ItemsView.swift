//
//  ItemsView.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import SwiftUI
import UIKit

struct ItemsView<ViewModel: ItemsViewModelType>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State private var showNote = false
    @State private var showContentCopied = false
    @State private var noteSheetData: (name: String, note: String) = ("", "")
    @State private var showAddItemView = false
    @State var listNoteHeight: CGFloat = 200
    private let selectedList: LeanList
    
    init(selecetList: LeanList) {
        self.selectedList = selecetList
        self.viewModel = ViewModel(selectedList: selecetList)
    }
    
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
                    .controlSize(.large)
                    .foregroundColor(.blue)
                    .padding()
            } else {
                List {
                    ForEach(viewModel.items) { item in
                        ListItemRowView(item) { note in
                            self.showNote = true
                            self.noteSheetData = (item.name, note)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.remove(at: indexSet)
                    }
                }
            }
        }
        .refreshable {
            viewModel.refresh()
        }
        .onAppear {
            viewModel.onAppear()
        }
        .navigationBarTitle(selectedList.name)
        .sheet(isPresented: $showNote) {
            VStack(spacing: 24) {
                Text(noteSheetData.name)
                    .font(.title3)
                    .padding(12)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .topLeading)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(noteSheetData.note)
                            .font(.headline)
                            .padding(12)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.leading)
                            .lineLimit(40, reservesSpace: false)
                            .frame(alignment: .topLeading)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    if UIDevice.current.orientation.isPortrait {
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200, alignment: .topLeading)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .padding(.horizontal, 14)
                Spacer()
            }
            .onLongPressGesture {
                UIPasteboard.general.string = """
                \(noteSheetData.name)
                
                \(noteSheetData.note)
                """
                UIPasteboard.general.image = UIImage(systemName: "info.circle")
                
                showContentCopied = true
            }
            .frame(maxWidth:. infinity)
            .padding()
            .presentationDetents([.medium])
            .onDisappear {
                showNote = false
                noteSheetData = ("", "")
            }
            .alert(isPresented: $showContentCopied) {
                Alert(title: Text("Item title and noes copied to pasteboard."), dismissButton: .default(Text("OK")))
            }
        }
        .sheet(isPresented: $showAddItemView) {
            AddItemView(selectedList.name, unavailableNames: viewModel.unavailableNames) {
                showAddItemView = false
            } onAdd: { item in
                showAddItemView = false
                viewModel.addItem(item)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                HStack {
                    Button {
                        Image(systemName: "doc.on.clipboard")
                            .resizable()
                            .frame(width: 24, height: 24)
                    } action: {
                        var text = ""
                        for item in viewModel.items {
                            text += "● \(item.name.trimmingSpaces.trimmingCharacters(in: .newlines))\n"
                            
                            if let note = item.note {
                                text += "\n\(note.trimmingSpaces.trimmingCharacters(in: .newlines))\n"
                            }
                            
                            text += "\n"
                        }
                        
                        UIPasteboard.general.string = text
                    }
                    
                    if !showAddItemView {
                        Button {
                            Image(systemName: "plus.square")
                                .resizable()
                                .frame(width: 24, height: 24)
                        } action: {
                            showAddItemView = true
                        }
                    }
                }
                .foregroundColor(.systemBlue)
                .padding(.top, 6)
                .padding(.trailing, 16)
            }
        }
    }
}

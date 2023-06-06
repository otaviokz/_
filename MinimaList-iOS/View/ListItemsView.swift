//
//  ListItemsView.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import SwiftUI

struct ListItemsView<ViewModel: ItemsViewModelType & ObservableObject>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State private var showNote = false
    @State private var notesSheetData: (name: String, notes: String) = ("", "")
    @State private var showAddItemView = false
    private let selectedList: LeanList
    
    init(_ selectedList: LeanList, viewModel: ViewModel = ItemsViewModel()) {
        self.viewModel = viewModel
        self.selectedList = selectedList
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
                        ListItemRowView(item) { notes in
                            self.showNote = true
                            self.notesSheetData = (item.name, notes)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.remove(at: indexSet)
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear(selectedList)
        }
        .navigationBarTitle(selectedList.name)
        .sheet(isPresented: $showNote) {
            VStack(spacing: 24) {
                Text(notesSheetData.name)
                    .font(.title3)
                    .padding(12)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .topLeading)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                
                VStack {
                    HStack {
                        Text(notesSheetData.notes)
                            .font(.headline)
                            .padding(12)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.leading)
                            .lineLimit(40, reservesSpace: false)
                            .frame(alignment: .topLeading)
                            .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        Spacer()
                        
                    }
                    .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 60, maxHeight: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                
                Spacer()
            }
            .frame(maxWidth:. infinity)
            .padding()
            .presentationDetents([.medium])
            .onDisappear {
                showNote = false
                notesSheetData = ("", "")
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
            if !showAddItemView {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "plus.square")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            showAddItemView = true
                        }
                        .padding(.trailing, 16)
                        .padding(.top, 6)
                }
            }
        }
    }
}

struct ListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemsView(LeanList("Groceries"), viewModel: PreviewItemsViewModel())
    }
}

//
//  ListsView.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import SwiftUI

struct ListsView<ViewModel: ListsViewModelType>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State var showAddListView: Bool = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                        .controlSize(.large)
                        .foregroundColor(.blue)
                } else {
                    List {
                        ForEach(viewModel.lists) { list in
                            NavigationLink(destination: ListItemsView(list)) {
                                LeanListRowView(list: list)
                            }
                            .accentColor(.secondary)
                        }
                        .onDelete { indexSet in
                            viewModel.remove(at: indexSet)
                        }
                    }
                }
            }
            .navigationTitle("Lists")
            .onAppear {
                viewModel.onAppear()
            }
            .sheet(isPresented: $showAddListView) {
                AddListView(unavailable: viewModel.unavailableNames) {
                    showAddListView = false
                } onAdd: { name, footNote in
                    showAddListView = false
                    self.viewModel.createList(name, footNote: footNote)
                }
            }
            .toolbar {
                if !showAddListView {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        addListToolbarImage
                    }
                }
            }
        }
    }
    
    var unavailableListNames: [String] {
        viewModel.lists.map { $0.name.lowercased() }
    }
    
    var addListToolbarImage: some View {
        Image("add.list")
            .resizable()
            .frame(width: 32, height: 32)
            .foregroundColor(.blue)
            .onTapGesture {
                showAddListView = true
            }
            .padding(.trailing, 16)
            .padding(.top, 6)
    }
}

struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView(viewModel: PreviewListsViewModel())
    }
}


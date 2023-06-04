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
                        }
                    }
                }
            }
            .navigationTitle("Lists")
            .onAppear {
                viewModel.onAppear()
            }
            .sheet(isPresented: $showAddListView) {
                AddListView(
                    unavailableListNames: unavailableListNames) {
                        showAddListView = false
                    } onAdd: { name, footNote in
                        showAddListView = false
                        self.viewModel.createList(name, footNote: footNote)
                    }
            }
            .toolbar {
                if !showAddListView {
                    ToolbarItem(placement: .navigationBarTrailing) {
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
            }
        }
    }
    
    var unavailableListNames: [String] {
        viewModel.lists.reduce([]) {
            [$1.name.lowercased()] + $0
        }
    }
}

private extension ListsView {
    var lists: some View {
        List {
            ForEach(viewModel.lists) { list in
                NavigationLink(destination: EmptyView()) {
                    LeanListRowView(list: list)
                }
            }
        }
    }
}



struct ListsView_Previews: PreviewProvider {
    static var previews: some View {
        ListsView(viewModel: PreviewListsViewModel())
    }
}


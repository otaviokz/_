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
                            if isRunningTets {
                                NavigationLink(destination: ItemsView<ItemsViewModel>(selecetList: list)) {
                                    LeanListRowView(list: list)
                                }
                            } else {
                                NavigationLink(destination: ItemsView<ItemsViewModel>(selecetList: list)) {
                                    LeanListRowView(list: list)
                                }
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
            .navigationTitle("Lists")
            .onAppear {
                viewModel.onAppear()
            }
            .sheet(isPresented: $showAddListView) {
                AddListView(unavailableNames: viewModel.unavailableNames) {
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
    
    var addListToolbarImage: some View {
        Button {
            Image("add.list")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.systemBlue)
        } action: {
            showAddListView = true
        }
        .padding(.trailing, 16)
        .padding(.top, 6)
    }
}

//struct ListsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListsView(viewModel: PreviewListsViewModel())
//    }
//}

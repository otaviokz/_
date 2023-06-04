//
//  ListsView.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 03/06/2023.
//

import SwiftUI

struct ListsView<ViewModel: ListsViewModelType>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoadingLists {
                    ProgressView()
                        .controlSize(.large)
                        .foregroundColor(.blue)
                    
                } else {
                    List {
                        ForEach(viewModel.lists) { list in
                            NavigationLink(destination: EmptyView()) {
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
            .toolbar {
                Image("add.list")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.blue)
                    .onTapGesture {

                    }
                    .padding(.trailing, 16)
                    .padding(.top, 6)
            }
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


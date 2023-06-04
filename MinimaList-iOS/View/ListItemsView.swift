//
//  ListItemsView.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import SwiftUI

struct ListItemsView<ViewModel: ItemsViewModelType & ObservableObject>: View {
    @ObservedObject private var viewModel: ViewModel
    @State private var showNote = false
    @State private var listIems: [ListItem] = []
    @State private var selectedItemNotes: String = ""
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
                            self.selectedItemNotes = notes
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.onAppear(selectedList)
        }
        .navigationBarTitle(selectedList.name)
        .sheet(isPresented: $showNote, onDismiss: { self.showNote = false }) {
            VStack {
                Text(selectedItemNotes)
                    .font(.title3)
                    .padding(12)
                    .multilineTextAlignment(.leading)
                    .frame(alignment: .topLeading)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                Spacer()
            }
            .padding()
            .presentationDetents([.medium])
            .onDisappear {
                showNote = false
                selectedItemNotes = ""
            }
        }
    }
}

struct ListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemsView(LeanList("Groceries"), viewModel: PreviewItemsViewModel())
    }
}

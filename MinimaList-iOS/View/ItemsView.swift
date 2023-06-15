//
//  ItemsView.swift
//  MinimaLists-iOS
//
//  Created by Otávio Zabaleta on 04/06/2023.
//

import SwiftUI

struct ItemsView<ViewModel: ItemsViewModelType>: View {
    @ObservedObject private(set) var viewModel: ViewModel
    @State private var showNote = false
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
          .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
              _ = calculateNoteHeight()
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
                
                VStack {
                    HStack {
                        Text(noteSheetData.note)
                            .font(.headline)
                            .padding(12)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.leading)
                            .lineLimit(40, reservesSpace: false)
                            .frame(alignment: .topLeading)
                        if UIDevice.current.orientation.isPortrait {
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    if UIDevice.current.orientation.isPortrait {
                        Spacer()
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .padding(.horizontal, 14)
                Spacer()
            }
            .frame(maxWidth:. infinity)
            .padding()
            .presentationDetents([.medium])
            .onDisappear {
                showNote = false
                noteSheetData = ("", "")
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
                        .frame(width: 24, height: 24)
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
    
    func calculateNoteHeight() -> CGFloat {
        if  UIDevice.current.orientation.isLandscape {
            listNoteHeight = 15
        } else {
            listNoteHeight = 200
        }
        return listNoteHeight
    }
}

//struct ListItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemsView<ViewModel: ItemsViewModelTypez>(LeanList("Groceries"), viewModel: PreviewItemsViewModel(selectedList: LeanList("")))
//    }
//}

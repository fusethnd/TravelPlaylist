//
//  JoerneyView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct JoerneyView: View {
    @StateObject var joerneyViewModel: JoerneyViewModel
    @StateObject var profileViewModel = ProfileViewModel()
    
    @FirestoreQuery var items: [PostItem]
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._joerneyViewModel = StateObject(wrappedValue: JoerneyViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
//                    PostItemView(item: item)
//                        .swipeActions {
//                            Button {
//                                viewModel.delete(id: item.id)
//                            } label: {
//                                Image(systemName: "trash.fill")
//                            }
//                            .tint(.red)
//                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Notes")
            .toolbar {
                Button {
                    joerneyViewModel.showingPostItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $joerneyViewModel.showingPostItemView) {
//                PostItemView(postItemPresented: $viewModel.showingPostItemView)
            }
        }
    }
}

struct JoeyneyView_Previews: PreviewProvider {
    static var previews: some View {
        JoerneyView(userId: "A7fMXIMP7pctLhRFNH5Ue17uzYB2")
    }
}

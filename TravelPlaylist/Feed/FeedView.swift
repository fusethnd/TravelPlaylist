//
//  FeedView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 30/4/2567 BE.
//

import Foundation
import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel() // userId: <#String#>)
    // PostItemViewModel()
    @State private var showingCreatePost = false
    
    var body: some View {
        // Text("Hello, World")
        NavigationView {
            // PostButton
            List(viewModel.feed) { item in
                  PostItemView(item: item)
            }
            .navigationBarTitle("Feed")
            .navigationBarItems(trailing: Button(action: {
                showingCreatePost = true
            }) {
                Image(systemName: "plus.circle.fill") // Stylish way to represent "add new post"
                    .resizable()
                    .frame(width: 30, height: 30)
                })
            .sheet(isPresented: $showingCreatePost) {
                CreatePostView(newItemPresented: $viewModel.showingCreatePostView) // Ensure CreateTweetView can handle its own environment and view model
            }
            .onAppear {
//                viewModel.fetchPostItem()
            }
//            .toolbar {
//                Button {
//                    viewModel.showingCreatePostView = true
//                } label: {
//                    Image(systemName: "plus")
//                }
//            }
//            .sheet(isPresented: $viewModel.showingCreatePostView) {
//                CreatePostView(newItemPresented: $viewModel.showingCreatePostView)
//            }
        }
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}

//
//  FeedView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 30/4/2567 BE.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.feed) { post in
                NavigationLink(destination: PostItemView(item: post)) {
                    VStack(alignment: .leading) {
                        Text("Author: \(post.authorName) (\(post.author))")
                        Text("Content: \(post.content)")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1)) // Add background to each post
                    .cornerRadius(10) // Add corner radius to the background
                    .padding(.horizontal) // Add horizontal padding to the background
                }
            }
            .navigationBarTitle("Feed")
            .navigationBarItems(trailing: Button(action: {
                viewModel.showingCreatePostView = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            })
            .sheet(isPresented: $viewModel.showingCreatePostView) {
                CreatePostView(newItemPresented: $viewModel.showingCreatePostView)
            }
            .onAppear {
                viewModel.fetchPostItem()
            }
        }
    }
}


//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}

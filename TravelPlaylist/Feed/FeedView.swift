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

    var body: some View {
        NavigationView {
            // PostButton
            List(viewModel.feed) { item in
                  PostItemView(item: item)
            }
            .navigationBarTitle("Feed")
            .toolbar {
                Button {
                    viewModel.showingCreatePostView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingCreatePostView) {
                CreatePostView(newItemPresented: $viewModel.showingCreatePostView)
            }
        }
        .navigationBarTitle("Feed")
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}

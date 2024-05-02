//
//  JoerneyView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import SwiftUI
import FirebaseFirestoreSwift

struct JourneyView: View {
    @StateObject var joerneyViewModel: JoerneyViewModel
    @StateObject var postItemViewModel = PostItemViewModel()
    
    init(userId: String) {
        self._joerneyViewModel = StateObject(wrappedValue: JoerneyViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            List(joerneyViewModel.posts) { post in
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
                Button {
                    postItemViewModel.delete(item: post)
                } label: {
                    Image(systemName: "trash.fill")
                }
                .tint(.red)
            }
            .navigationBarTitle("Journey")
        }
    }
}


//struct JoerneyView: View {
//    @StateObject var joerneyViewModel: JoerneyViewModel
//    
//    init(userId: String) {
//        self._joerneyViewModel = StateObject(wrappedValue: JoerneyViewModel(userId: userId))
//    }
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                List(joerneyViewModel.posts) { post in
//                    PostItemView(item: post)
//                }
//                .padding()
//                .background(Color.gray.opacity(0.1)) // Add background to each post
//                .cornerRadius(10) // Add corner radius to the background
//                .padding(.horizontal) // Add horizontal padding to the background
//                .navigationTitle("My Journey")
//            }
//            .navigationBarTitle("Journey")
//        }
//    }
//}


//struct JoeyneyView_Previews: PreviewProvider {
//    static var previews: some View {
//        JoerneyView(userId: "kSHThjwK0DPwt4hrCsu2dQ17gHU2")
//    }
//}

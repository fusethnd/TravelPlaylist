//
//  CreatePostView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import SwiftUI

struct CreatePostView: View {
    @ObservedObject var viewModel = CreatePostViewModel()
    @Binding var newItemPresented: Bool
    // @State private var showingAddingMusic = false
    
    var body: some View {
        NavigationView {
            VStack {
//                Text("Create Post")
//                    .font(.system(size: 32))
//                    .bold()
//                    .padding(.top, 50)
                
                Form {
                    ScrollView {
                        TextField("What’s happening?", text: $viewModel.content)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        // ResultView(newItemPresented: $viewModel.showingAddingMusic)
                    }
                    .padding()
                    .border(Color.gray, width: 1)
                    
                    NavigationLink("Add Music", destination: ResultView())
                    
                    TLButton(title: "Post", background: .blue) {
                        if viewModel.canPost {
                            viewModel.post()
                            newItemPresented = false
                        } else {
                            viewModel.showAlert = true
                        }
                    }
                    .padding()
    //                Button("Post") {
    //                    if viewModel.canPost {
    //                        viewModel.post()
    //                        newItemPresented = false
    //                    } else {
    //                        viewModel.showAlert = true
    //                    }
    //                }
    //                .padding()
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("Please fill in all fields.")
                    )
                }
            }
            .navigationTitle("Create Post")
        }
    }
}

//struct CreatePostView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePostView(newItemPresented: .constant(true))
//    }
//}

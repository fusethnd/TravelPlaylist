//
//  CreatePostView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import SwiftUI

struct CreatePostView: View {
    @StateObject var viewModel = CreatePostViewModel()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
            Text("Create Post")
                .font(.system(size: 32))
                .bold()
                .padding(.top, 50)
            
            Form {
//                TextField("Title", text: $viewModel.title)
//                    .textFieldStyle(DefaultTextFieldStyle())
                               
                ScrollView {
                    TextEditor(text: $viewModel.content)
                        .frame(minHeight: 300, maxHeight: .infinity) // Adjust minimum height as needed
                        .padding()
                    
                    // Display Location Selected
                    
                    // Display Song Selected
                    
                }
                .border(Color.gray, width: 1)
                
                // Add MapsView

                TLButton(title: "Post", background: .pink) {
                    if viewModel.canPost {
                        viewModel.post()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Please fill in all fields.")
                )
            }
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(newItemPresented: .constant(true))
    }
}

//
//  CreatePostView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import SwiftUI
import MapKit

struct CreatePostView: View {
    @ObservedObject var viewModel = CreatePostViewModel()
    @Binding var newItemPresented: Bool
    @State private var position: MapCameraPosition = .userLocation(fallback: .automatic)
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
                    
                    HStack {
                        Map(position: $position) {}
                            .onAppear{
                                CLLocationManager().requestWhenInUseAuthorization()
                            }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    
                    
//                    MapsView(latitude: item.latitude,longitude: item.longitude)
//                        .padding()
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(Color.blue.opacity(0.3))
//                        .cornerRadius(10)
//                        .padding()
                    
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

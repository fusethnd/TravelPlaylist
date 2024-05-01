//
//  ProfileView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 10/4/2567 BE.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                        .frame(width: 125, height: 125)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Username: ")
                            Text("@\(user.username)")
                        }
                        HStack {
                            Text("Name: ")
                            Text(user.name)
                        }
                        HStack {
                            Text("Email: ")
                            Text(user.email)
                        }
                        HStack {
                            Text("Member Since: ")
                            Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                        }
                    }
                    
                    Button {
                        // List of playlistItem
                        
                        
                    } label: {
                        Text("Add Playlist")
                    }
                    
                    Button {
                        viewModel.logOut()
                    } label: {
                        Text("Logout")
                    }
                } else {
                    Text("Loading Profile...")
                    Button {
                        viewModel.logOut()
                    } label: {
                        Text("Logout")
                    }
                }
            }
            .onAppear {
                viewModel.fetchUser()
            }
        }
        .navigationBarTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

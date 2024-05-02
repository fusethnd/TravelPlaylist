//
//  ContentView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 5/4/2567 BE.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            accountView
        } else {
            LoginView()
        }
    }
    
    var accountView: some View {
        TabView { // Navigation
            // Feed page
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "note.text")
                }
            
            JoerneyView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("My Journey", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            MapsView()
                .tabItem {
                    Label("MapsView", systemImage: "map.fill")
                }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

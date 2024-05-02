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
            FeedView(viewModel: FeedViewModel())
                .tabItem {
                    Label("Feed", systemImage: "note.text")
                }
            
            JourneyView(userId: viewModel.currentUserId)
                .tabItem {
                    Label("My Journey", systemImage: "house")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//  LoginViewModel.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 10/4/2567 BE.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @StateObject var spotifyModel = SpotifyAuthViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "TravelPlaylist", subtitle: "Make your playlist on the way", angle: 15, background: .pink)
                
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    TLButton(title: "Log In", background: .blue) {
                        viewModel.login()
                    }
                    
                    TLButton(title: "Log In via Spotify", background: .green) {
                         spotifyModel.authenticate()
                        // When the user taps the button, the app should open a web view or Safari to show the Spotify authorization page.
                    }
                }
                VStack {
                    Text("Don't have an Account?")
                    NavigationLink("Create an Account", destination: RegisterView())
                }
                
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

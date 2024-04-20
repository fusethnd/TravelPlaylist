//
//  SpotifyAuthViewModel.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 14/4/2567 BE.
//

import Foundation
import SwiftUI
import OAuthSwift

class SpotifyAuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    
    private var oauthSwift: OAuth2Swift?

    func authenticate() {
        self.oauthSwift = OAuth2Swift(
            consumerKey:    "fe423f7bfe824064aa061defe197c55d",
            consumerSecret: "e5c6636e6b8a474382aefba3b7e78122",
            authorizeUrl:   "https://accounts.spotify.com/authorize",
            accessTokenUrl: "https://accounts.spotify.com/api/token",
            responseType:   "code"
        )

        let callbackUrl = "https://open.spotify.com" // Make sure this matches the one in your URL Schemes
        let scope = "user-read-private user-read-email" // Define the scopes as per your need
        
        oauthSwift?.authorize(
            withCallbackURL: URL(string: callbackUrl)!,
            scope: scope,
            state: "SPOTIFY",
            completionHandler: { result in
                switch result {
                case .success(let (credential, _, _)):
                    // Handle successful authentication
                    self.isAuthenticated = true
                    print("Spotify access token: \(credential.oauthToken)")
                    // You might want to save the token here using Keychain or another secure storage method
                case .failure(let error):
                    // Handle authentication errors
                    print("Authentication Error: \(error.localizedDescription)")
                }
            }
        )
    }
}

//func spotifyLogin() {
//    let authURL = "https://accounts.spotify.com/authorize?client_id=\(clientID)&response_type=code&redirect_uri=\(redirectURI)&scope=\(scopes)&show_dialog=true"
//
//    if let url = URL(string: authURL) {
//        UIApplication.shared.open(url)
//    }
//    
//    // get email to signin
//    
//}

//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        guard let url = webView.url else {
//            return
//        }
//
//        // Exchange the code for access token
//        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value
//            else {
//            return
//        }
//        webView.isHidden = true
//
//        print("Code: \(code)")
//        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
//            DispatchQueue.main.async {
//                self?.navigationController?.popToRootViewController(animated: true)
//                self?.completionHandler?(success)
//            }
//        }
//    }

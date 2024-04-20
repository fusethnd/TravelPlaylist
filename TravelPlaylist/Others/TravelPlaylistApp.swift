//
//  TravelPlaylistApp.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 5/4/2567 BE.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct TravelPlaylistApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainView()
                    .onOpenURL { url in
                        handleURL(url: url)
                    }
            }
        }
    }
    
    func handleURL(url: URL) {
        // Check if the URL is the redirect from Spotify
        // Extract the authorization code or token from the URL
        // Continue with your authentication process
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queryItems = urlComponents?.queryItems, let code = queryItems.first(where: { $0.name == "code" })?.value {
            exchangeCodeForToken(code: code)
        }
    }
    
    func exchangeCodeForToken(code: String) {
        let clientID = "fe423f7bfe824064aa061defe197c55d"
        let clientSecret = "e5c6636e6b8a474382aefba3b7e78122"  // Be cautious with your client secret
        let redirectURI = "spotify-ios-quick-start://spotify-login-callback"

        let tokenURL = "https://accounts.spotify.com/api/token"
        var request = URLRequest(url: URL(string: tokenURL)!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        

        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "client_secret", value: clientSecret)
        ]
        request.httpBody = components.query?.data(using: .utf8)
        request.setValue("Basic", forHTTPHeaderField: "Authorization")
        
//        let bodyComponents = URLComponents(queryItems: [
//            URLQueryItem(name: "grant_type", value: "authorization_code"),
//            URLQueryItem(name: "code", value: code),
//            URLQueryItem(name: "redirect_uri", value: redirectURI),
//            URLQueryItem(name: "client_id", value: clientID),
//            URLQueryItem(name: "client_secret", value: clientSecret)
//        ])
        
        let basicToken = clientID + ":" + clientSecret
        let data = basicToken.data(using: .utf8)
        let base64String = data?.base64EncodedString()
        guard let base64String = data?.base64EncodedString() else {
            print("Failed to get base64")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to request access token")
                return
            }
            
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print("SUCCESS")
//            } catch {
//                print(error.localizedDescription)
//                completion(false)
//            }
            
            if let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: data) {
                // Store your access token, refresh token, etc.
                // For example, using UserDefaults (not recommended for production!)
                UserDefaults.standard.setValue(tokenResponse.accessToken, forKey: "SpotifyAccessToken")
                // Now you can use the access token to make requests to Spotify's Web API
            }
        }.resume()
    }
}


//@main
//struct TravelPlaylistApp: App {
//    init() {
//        FirebaseApp.configure()
//    }
//    var body: some Scene {
//        WindowGroup {
//            MainView()
//        }
//    }
//}


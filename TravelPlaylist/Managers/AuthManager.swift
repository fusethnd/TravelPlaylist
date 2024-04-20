//
//  AuthManager.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 12/4/2567 BE.
//

//import Foundation
//
//final class AuthManager {
//    static let shared = AuthManager()
//    
//    struct Constants {
//        static let clientID = "fe423f7bfe824064aa061defe197c55d"
//        static let clientSecret = "e5c6636e6b8a474382aefba3b7e78122"
//        static let tokenURL = "https://accounts.spotify.com/api/token"
//    }
//    
//    private init() {}
//    
//    public var signInURL: URL? {
//        let redirectURI = "https://open.spotify.com"
//        let scopes = "user-read-private"  // Add other scopes as needed
////        let clientID = "fe423f7bfe824064aa061defe197c55d"
//        let base = "https://accounts.spotify.com/authorize"
//        let authURL = "\(base)?client_id=\(Constants.clientID)&response_type=code&redirect_uri=\(redirectURI)&scope=\(scopes)&show_dialog=true"
////        let authURL = "https://accounts.spotify.com/authorize?client_id=\(clientID)&response_type=code&redirect_uri=\(redirectURI)&scope=\(scopes)&show_dialog=true"
//        return URL(string: authURL)
//    }
//    
//    var isSignedIn: Bool {
//        return false
//    }
//    
//    private var accessToken: String? {
//        return nil
//    }
//    
//    private var refreshToken: String? {
//        return nil
//    }
//    
//    private var tokenExpirationDate: Date? {
//        return nil
//    }
//    
//    private var shouldRefreshToken: Bool? {
//        return false
//    }
//    
//    func exchangeCodeForToken(
//        code: String,
//        completion: @escaping ((Bool) -> Void)
//    ) {
//        // Get Token
//        guard let url = URL(string: Constants.tokenURL) else {
//            return
//        }
//        
//        let tokenURL = "https://accounts.spotify.com/api/token"
//        var request = URLRequest(url: URL(string: tokenURL)!)
//        request.httpMethod = "POST"
//        
////        let task = URLSession.shared.dataTask(with: request) { data _, error in
////            guard let data = data,
////                  error == nil else {
////                completion(false)
////                return
////            }
////        }
//        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//
//        let bodyComponents = URLComponents(queryItems: [
//            URLQueryItem(name: "grant_type", value: "authorization_code"),
//            URLQueryItem(name: "code", value: code),
//            URLQueryItem(name: "redirect_uri", value: redirectURI),
//            URLQueryItem(name: "client_id", value: clientID),
//            URLQueryItem(name: "client_secret", value: clientSecret)
//        ])
//        request.httpBody = bodyComponents.query?.data(using: .utf8)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Failed to request access token")
//                return
//            }
//
//            if let tokenResponse = try? JSONDecoder().decode(TokenResponse.self, from: data) {
//                // Store your access token, refresh token, etc.
//                // For example, using UserDefaults (not recommended for production!)
//                UserDefaults.standard.setValue(tokenResponse.accessToken, forKey: "SpotifyAccessToken")
//                // Now you can use the access token to make requests to Spotify's Web API
//            }
//        }.resume()
//    }
//}

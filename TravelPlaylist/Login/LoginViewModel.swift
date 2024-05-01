//
//  LoginViewModel.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 10/4/2567 BE.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password)
    }
}

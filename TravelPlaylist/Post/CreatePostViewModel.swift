//
//  CreatePostViewModel.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class CreatePostViewModel: ObservableObject {
    @Published var content = ""
    @Published var author = ""
    @Published var authorName = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func post() {
        guard canPost else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        // First, check if the user email is available
        if let authMail = Auth.auth().currentUser?.email {
            db.collection("users").whereField("email", isEqualTo: authMail)
                .getDocuments { (querySnapshot, err) in
                    if let err = err {
                        self.showAlert = true
                        self.alertMessage = "Error fetching user data: \(err.localizedDescription)"
                        print("Error getting documents: \(err)")
                    } else if let querySnapshot = querySnapshot, querySnapshot.documents.isEmpty == false {
                        let document = querySnapshot.documents.first
                        let username = document?.data()["username"] as? String ?? "Unknown"
                        let name = document?.data()["name"] as? String ?? "Unknown"
                        self.author = "@\(username)"
                        self.authorName = name

                        // Create the new post item within the completion handler
                        let newId = UUID().uuidString
                        let newItem = PostItem(
                            id: newId,
                            authorName: self.authorName,
                            author: self.author,
                            content: self.content,
                            createDate: Date().timeIntervalSince1970
                        )
                        
                        // Upload the post to Firestore
                        db.collection("users")
                            .document(uid)
                            .collection("journey")
                            .document(newId)
                            .setData(newItem.asDictionary()) { error in
                                if let error = error {
                                    self.showAlert = true
                                    self.alertMessage = "Error posting: \(error.localizedDescription)"
                                    print("Error adding document: \(error)")
                                } else {
                                    print("Document added with ID: \(newId)")
                                    self.content = "" // Clear input after successful post
                                }
                            }
                    } else {
                        self.showAlert = true
                        self.alertMessage = "No user found with email \(authMail)"
                        print("No documents found")
                    }
                }
        } else {
            self.showAlert = true
            self.alertMessage = "No logged-in user or user does not have an email"
            print("No logged in user or user does not have an email")
        }
    }
    
    var canPost: Bool {
        return !content.isEmpty && content.count <= 250
    }
}

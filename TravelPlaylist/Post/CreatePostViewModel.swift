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

    @Published var showAlert = false
    @Published var alertMessage = ""
    
    func post() {
        guard canPost else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let newId = UUID().uuidString
        
        let newItem = PostItem(
            id: newId,
            author: (Auth.auth().currentUser?.email)!,
            content: content,
            createDate: Date().timeIntervalSince1970
        )
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("journey")
            .document(newId)
            .setData(newItem.asDictionary()) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                    self.showAlert = true
                    self.alertMessage = "Error posting: \(error.localizedDescription)"
                } else {
                    print("Document added with ID: \(newId)")
                    self.content = "" // Clear input after successful post
                }
            }
    }
    
    var canPost: Bool {
        return !content.isEmpty && content.count <= 250
    }
}

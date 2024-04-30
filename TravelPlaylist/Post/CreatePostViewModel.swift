//
//  CreatePostViewModel.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CreatePostViewModel: ObservableObject {
    @Published var author = "" // User.name
    @Published var content = ""
    @Published var location = ""
    @Published var track = ""
    @Published var showAlert = false
    
    func createPost(content: String) {
        // Firebase function to add tweet
        let db = Firestore.firestore()
        let tweetData: [String: Any] = [
            "author": "Anonymous",  // Example: Fixed author, replace with actual user data if available
            "content": content,
            "createDate": Timestamp(date: Date())
        ]
        db.collection("tweets").addDocument(data: tweetData) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    
    func post() {
        guard canPost else { return }
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let newId = UUID().uuidString
        let newItem = PostItem(
            id: newId,
            author: author,
            content: content,
            createDate: Date().timeIntervalSince1970 //,
//            location: location,
//            track: track
        )
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("posts")
            .document(newId)
            .setData(newItem.asDictionary())
    }
    
    var canPost: Bool {
        // don't lack of any post
        // let the chaaracters of content not over 250 char
        guard (content.count > 250 && content.count < 1) else {
            return false
        }
        

//        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
//            return false
//        }
        
        return true
    }
}

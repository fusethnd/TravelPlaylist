//
//  JoerneyViewModel.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class JoerneyViewModel: ObservableObject {
    @Published var posts: [PostItem] = [] // Array to store fetched posts
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    private let userId: String
    private let db = Firestore.firestore()

    init(userId: String) {
        self.userId = userId
        fetchPosts() // Fetch posts from Firebase when initializing the ViewModel
    }
    
    // Function to fetch posts from Firebase Firestore
    func fetchPosts() {
        db.collection("users")
            .document(userId)
            .collection("journey")
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.posts = documents.compactMap { document in
                    do {
                        return try document.data(as: PostItem.self)
                    } catch {
                        print("Error decoding post item: \(error)")
                        return nil
                    }
                }
            }
    }
    
    // Function to delete a post from Firebase Firestore
    func deletePost(id: String) {
        db.collection("users")
            .document(userId)
            .collection("journey")
            .document(id)
            .delete { error in
                if let error = error {
                    print("Error deleting document: \(error)")
                } else {
                    print("Document successfully deleted")
                }
            }
    }
}

//
//  FeedViewModel.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 30/4/2567 BE.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FeedViewModel: ObservableObject {
    @Published var showingCreatePostView = false
    @Published var showingPostItemView = false
    
    @Published var title = ""
    @Published var content = ""
    @Published var showAlert = false
    @Published var feed = [PostItem]()
    
    // private let userId: String
    // private let db = Firestore.firestore()
    
    init() { // userId: String) {
        // self.userId = userId
        fetchPostItem()
    }

    private func fetchPostItem() {
        let db = Firestore.firestore()
        db.collection("feeds").getDocuments { snapshot, error in
            if let snapshot = snapshot {
                self.feed = snapshot.documents.map { doc in
                    let timestamp = (doc["createDate"] as? Timestamp) ?? Timestamp()
                    let createDate = timestamp.dateValue().timeIntervalSince1970
                    return PostItem(id: doc.documentID,
                        author: doc["author"] as? String ?? "",
                        content: doc["content"] as? String ?? "",
                        createDate: createDate)
                }
            }
        }
    }
}

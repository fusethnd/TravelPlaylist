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
//    @Published var showingPostItemView = false
//    
//    @Published var title = ""
//    @Published var content = ""
//    @Published var showAlert = false
    @Published var feed = [PostItem]()
    
    // private let userId: String
    private var db = Firestore.firestore()
    
    init() { // userId: String) {
        // self.userId = userId
        fetchPostItem()
    }
    
    func fetchPostItem() {
        db.collection("journey")
            .order(by: "createDate", descending: true)  // Assuming tweets are stored with a 'createDate' field
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.feed = snapshot?.documents.compactMap { document -> PostItem? in
                        try? document.data(as: PostItem.self)
                    } ?? []
                }
            }
    }

//    func fetchPostItem() {
//        let db = Firestore.firestore()
//        db.collection("journey")
//            .order(by: "createDate", descending: true) // actually order by nearest (2km radius)
//            .getDocuments { snapshot, error in
//            if let snapshot = snapshot {
//                self.feed = snapshot.documents.map { doc in
//                    let timestamp = (doc["createDate"] as? Timestamp) ?? Timestamp()
//                    let createDate = timestamp.dateValue().timeIntervalSince1970
//                    return PostItem(id: doc.documentID,
//                        author: doc["author"] as? String ?? "",
//                        content: doc["content"] as? String ?? "",
//                        createDate: createDate)
//                }
//            }
//        }
//    }
}

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
    @Published var showingPostItemView = false
    @Published var title = ""
    @Published var content = ""
    @Published var showAlert = false
    
    private let userId: String
    private let db = Firestore.firestore()

    init(userId: String) {
        self.userId = userId
    }
    
    func delete(id: String) {
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
}

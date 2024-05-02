//
//  PostItemView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class PostItemViewModel: ObservableObject {
    // tap item to see a post
    func toggleIsDone(item: PostItem) {
        let itemCopy = item
//        itemCopy.setDone(!item.isDone)

        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("journey")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
    
    func delete(item: PostItem) {
        let itemCopy = item
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("journey")
            .document(itemCopy.id)
            .delete()
    }
}

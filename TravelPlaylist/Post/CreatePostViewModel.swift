//
//  CreatePostViewModel.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import SwiftUI
import CoreLocation // Add this line
import Firebase
import FirebaseAuth
import FirebaseFirestore

class CreatePostViewModel: NSObject, ObservableObject {
    @Published var content = ""
    @Published var author = ""
    @Published var authorName = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var latitude: Double = 0
    @Published var longitude: Double = 0
    
    // @Published var showingAddingMusic = false
    
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
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
                    } else if let querySnapshot = querySnapshot, let document = querySnapshot.documents.first {
                        let username = document.data()["username"] as? String ?? "Unknown"
                        let name = document.data()["name"] as? String ?? "Unknown"
                        self.author = "@\(username)"
                        self.authorName = name

                        // Create the new post item within the completion handler
                        let newId = UUID().uuidString
                        let newItem = PostItem(
                            id: newId,
                            authorName: self.authorName,
                            author: self.author,
                            content: self.content,
                            createDate: Date().timeIntervalSince1970,
                            latitude: self.latitude,
                            longitude: self.longitude // Include latitude and longitude here
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

extension CreatePostViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        // Stop updating location after the first successful update
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

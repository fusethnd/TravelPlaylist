//
//  TravelPlaylistApp.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 5/4/2567 BE.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct TravelPlaylistApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
//            MapsView()
        }
    }
}

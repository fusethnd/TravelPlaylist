//
//  PostContentView.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 24/4/2567 BE.
//

import Foundation

class PostContentViewModel: ObservableObject {
    @Published var showingItemView = false

    private let userId: String

    init(userId: String) {
        self.userId = userId
    }
}

// show profile

// show location

// show content

// show track

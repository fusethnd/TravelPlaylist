//
//  PostItem.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 10/4/2567 BE.
//

import Foundation

struct PostItem: Codable, Identifiable {
    let id: String
    let owner: User
    let content: String
    let createDate: TimeInterval
//    let location: Location
//    let track: Track
}

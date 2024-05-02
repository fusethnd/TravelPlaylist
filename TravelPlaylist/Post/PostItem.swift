//
//  PostItem.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 10/4/2567 BE.
//

import Foundation

struct PostItem: Codable, Identifiable {
    let id: String
    let authorName: String
    let author: String
    let content: String
    let createDate: TimeInterval
    let latitude: Double
    let longitude: Double
//    let location: locationItem // String of location (latitude,longtitide)
//    let track: TrackItem
//  let trackURI: String
}

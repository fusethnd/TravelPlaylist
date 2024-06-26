//
//  User.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 10/4/2567 BE.
//

import Foundation

struct User: Codable {
    let id: String
    let name: String
    let username: String
    let email: String
    let joined: TimeInterval
}

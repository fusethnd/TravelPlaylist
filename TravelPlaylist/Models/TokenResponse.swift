//
//  TokenResponse.swift
//  TravelPlaylist
//
//  Created by Thanadon Boontawee on 10/4/2567 BE.
//

import Foundation

struct TokenResponse: Decodable {
    var accessToken: String
    var tokenType: String
    var expiresIn: Int
    var refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
    }
}

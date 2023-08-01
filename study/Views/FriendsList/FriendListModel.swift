//
//  FriendListModel.swift
//  study
//
//  Created by Dursun YILDIZ on 31.07.2023.
//

import Foundation
struct User: Codable {
    let gender: String
    let name: Name
    let picture: Picture
    let phone: String
    let location: Location
    let email: String
    // Add other properties from the JSON response as needed
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct FriendList: Codable {
    let results: [User]
}

struct Picture: Codable {
    let thumbnail, large: String
}

struct Coordinates: Codable {
    let latitude, longitude: String
}

struct Location: Codable {
    let coordinates: Coordinates
}

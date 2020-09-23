//
//  User.swift
//  TaskManager
//
//  Created by Olgu on 25.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation
import SwiftUI

// let mockUser =

struct User: Identifiable {
    let id: String
    let name: String
    let profileImageName: String
}

private let user1 = User(id: UUID().uuidString, name: "John Lennon", profileImageName: "user1")
private let user2 = User(id: UUID().uuidString, name: "Paul McCartney", profileImageName: "user2")
private let user3 = User(id: UUID().uuidString, name: "George Harrison", profileImageName: "user3")
private let user4 = User(id: UUID().uuidString, name: "Ringo Starr", profileImageName: "user4")
private let user5 = User(id: UUID().uuidString, name: "Billy Preston", profileImageName: "user5")

private let users = [user1, user2, user3, user4, user5]

func getRandomUser() -> User {
    users.randomElement()!
}

func getRandomMemberNumber() -> Int {
    Int.random(in: 5 ..< 20)
}

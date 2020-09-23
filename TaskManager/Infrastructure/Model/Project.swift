//
//  Project.swift
//  TaskManager
//
//  Created by Olgu on 6.09.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct Project: Identifiable, Equatable, Hashable {
    static let empty = Project(title: "", description: "", memberCount: 0, members: [])

    var id: String = UUID().uuidString
    var dueDate = Date()
    var title: String
    var description: String
    var memberCount: Int = getRandomMemberNumber()
    var members: [User]

    // MARK: Equatable

    static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id
    }

    // MARK: Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(title)
        hasher.combine(description)
    }
}

let project1 = Project(title: "SpaceX", description: "Live another planet", members: [getRandomUser(), getRandomUser(), getRandomUser()])
let project2 = Project(title: "The Boring Company", description: "Less trafic", members: [getRandomUser(), getRandomUser(), getRandomUser()])
let project3 = Project(title: "Hyperloop", description: "Rail system in a tube", members: [getRandomUser(), getRandomUser(), getRandomUser()])
let project4 = Project(title: "SolarCity", description: "Solar panels", members: [getRandomUser(), getRandomUser(), getRandomUser()])
let project5 = Project(title: "Tesla", description: "Electric and Hybrid Vehicle", members: [getRandomUser(), getRandomUser(), getRandomUser()])

let mockProjects = [project1, project2, project3, project4, project5]

//
//  Activity.swift
//  TaskManager
//
//  Created by Olgu on 30.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import SwiftUI

struct ActivityPageModel: Identifiable {
    var id: String = UUID().uuidString
    var date = Date()
    var activities: [Activity]
}

struct Activity: Identifiable {
    enum TaskType {
        case loved
        case readyToLove
        case readyToGet
        case readyToComplete
        case completed
    }

    var id: String = UUID().uuidString
    var title: String
    var description: String
    var type: TaskType
    var user: User = getRandomUser()
}

let activity1 = Activity(title: "Luke completed 2 tasks", description: "Website Launch", type: .loved)
let activity2 = Activity(title: "Assigned to you by Andy", description: "Main Page", type: .readyToLove)

let activity3 = Activity(title: "Luke completed 7 tasks", description: "Website Launch", type: .readyToGet)
let activity4 = Activity(title: "Nami added a new project", description: "Subtitle", type: .readyToComplete)
let activity5 = Activity(title: "Assigned to you by Patrick", description: "Main Page", type: .loved)

let activity6 = Activity(title: "Luke completed 2 tasks", description: "Website Launch", type: .readyToLove)
let activity7 = Activity(title: "Nami added a new project", description: "Mobile App Development", type: .readyToGet)
let activity8 = Activity(title: "Luke completed 2 tasks", description: "Website Launch", type: .completed)

let section1 = ActivityPageModel(activities: [activity1, activity2])
let section2 = ActivityPageModel(activities: [activity3, activity4, activity5])
let section3 = ActivityPageModel(activities: [activity6, activity7, activity8])

let activitiesMock = [section1, section2, section3]

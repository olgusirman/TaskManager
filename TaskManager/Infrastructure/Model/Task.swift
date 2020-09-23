//
//  Task.swift
//  TaskManager
//
//  Created by Olgu on 25.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation
import SwiftUI

struct Task: Codable, Identifiable {
    let id: String = UUID().uuidString
    let taskDescription: String
    let isChecked: Bool
    let date: Date
    let isLate: Bool

    var formattedDate: String {
        taskFormatter.string(from: date)
    }

    var formattedAlertDate: String {
        taskAlertFormatter.string(from: date)
    }
}

private let task1 = Task(taskDescription: "Find the meaning of life", isChecked: false, date: Date(), isLate: true)
private let task2 = Task(taskDescription: "Less task, more space", isChecked: true, date: Date(), isLate: false)
private let task3 = Task(taskDescription: "The best task is finished task", isChecked: false, date: Date().yesterday, isLate: false)
private let task4 = Task(taskDescription: "Don't care, client can handle it", isChecked: true, date: Date().tomorrow, isLate: true)
private let task5 = Task(taskDescription: "Turn bugs to the features", isChecked: false, date: Date(), isLate: false)

let mockTasks = [task1, task2, task3, task4, task5]

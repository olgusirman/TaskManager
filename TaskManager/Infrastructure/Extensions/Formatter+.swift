//
//  Formatter+.swift
//  TaskManager
//
//  Created by Olgu on 26.08.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation

let longFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMM d, h:mm a"
    return formatter
}()

let taskFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, HH:mm"
    return formatter
}()

let taskAlertFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    return formatter
}()

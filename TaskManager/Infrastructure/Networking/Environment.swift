//
//  Environment.swift
//  TaskManager
//
//  Created by Olgu on 7.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation

struct TaskManagerEnvironment {

  // MARK: - Properties
  var baseUrl: URL
}

extension TaskManagerEnvironment {
  static let prod = TaskManagerEnvironment(baseUrl: URL(string: "{someBaseURLHere}")!)
}

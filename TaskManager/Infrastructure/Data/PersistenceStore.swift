//
//  PersistenceStore.swift
//  TaskManager
//
//  Created by Olgu on 7.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation

final class SomeDB {}

final class PersistenceStore {
  let db: SomeDB
  let workerQueue = DispatchQueue(label: "com.taskManager.persistence", qos: .background)
  
  init(db: SomeDB) {
    self.db = db
  }
}

//
//  DataCache.swift
//  TaskManager
//
//  Created by Olgu on 7.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Combine

enum DataCacheError: Error {
  case cacheMiss
  
  var localizedDescription: String {
    switch self {
    case .cacheMiss:
      return "DataCacheError::CacheMiss"
    }
  }
}

final class DataCache: ObservableObject {
  enum CacheChange {
    case updated
  }
  
  enum CacheInvalidation {
    case progressions
    case bookmarks
  }
  
    // updatable some data
  private var contents: [Int: Any] = [:]
  
  private let objectDidChange = CurrentValueSubject<CacheChange, Never>(.updated)
  
  let cacheWasInvalidated = PassthroughSubject<CacheInvalidation, Never>()
}

extension DataCache {
  func update(from cacheUpdate: Any) {
    
    // Update some data's here
    
    objectDidChange.send(.updated)
  }
}

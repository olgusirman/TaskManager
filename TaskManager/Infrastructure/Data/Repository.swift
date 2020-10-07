//
//  Repository.swift
//  TaskManager
//
//  Created by Olgu on 7.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Combine

class Repository {
    private let persistenceStore: PersistenceStore
    private let dataCache: DataCache
    
    init(persistenceStore: PersistenceStore, dataCache: DataCache) {
        self.persistenceStore = persistenceStore
        self.dataCache = dataCache
    }
}

extension Repository {
    
    func someUpdateableRepositoryHelper() -> AnyPublisher<Any, Error> {
        Empty().eraseToAnyPublisher()
    }
    
}

// MARK: - Cache invalidations
extension Repository {
    var cachedBookmarksInvalidated: AnyPublisher<Void, Never> {
        dataCache
            .cacheWasInvalidated
            .filter { $0 == .bookmarks }
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    var cachedProgressionsInvalidated: AnyPublisher<Void, Never> {
        dataCache
            .cacheWasInvalidated
            .filter { $0 == .progressions }
            .map { _ in }
            .eraseToAnyPublisher()
    }
}

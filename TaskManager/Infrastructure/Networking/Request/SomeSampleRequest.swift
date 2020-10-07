//
//  SomeSampleRequest.swift
//  TaskManager
//
//  Created by Olgu on 6.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation

struct SomeSampleRequest: Request {
    typealias Response = (object: Any, cacheUpdate: Any)
  
  // MARK: - Properties
  var method: HTTPMethod { .GET }
  var path: String { "/somePath" }
  var additionalHeaders: [String: String] = [:]
  var body: Data? { nil }
  var parameters: [Parameter]? { nil }
  
  // MARK: - Internal
  func handle(response: Data) throws -> Response {
    
    // TODO: parse Data and convert the JSON
    // TODO: use cache mechanism here
    // TODO: return object
    let object = 0
    
    return (object: object, cacheUpdate: object)
  }
}

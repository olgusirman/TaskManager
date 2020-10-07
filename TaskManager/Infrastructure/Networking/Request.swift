//
//  Request.swift
//  TaskManager
//
//  Created by Olgu on 6.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation

struct Parameter: Hashable, Codable {
  let key: String
  let value: String
}

enum HTTPMethod: String {
  case GET
  case POST
  case PUT
  case DELETE
  case PATCH
}

protocol Request {
  associatedtype Response

  var method: HTTPMethod { get }
  var path: String { get }
  var additionalHeaders: [String: String] { get }
  var body: Data? { get }

  func handle(response: Data) throws -> Response
}

// Default implementation to .GET
extension Request {
  var method: HTTPMethod { .GET }
  var body: Data? { nil }
}

enum RequestError: Error {
  case responseMissingRequiredMeta(field: String?)
  
  var localizedDescription: String {
    let prefix = "RequestError::"
    switch self {
    case .responseMissingRequiredMeta(field: let field):
      return "\(prefix)ResponseMissingRequiredMeta: [Field: \(field ?? "UNKNOWN")]"
    }
  }
}

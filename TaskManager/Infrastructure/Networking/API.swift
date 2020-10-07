//
//  API.swift
//  TaskManager
//
//  Created by Olgu on 7.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias HTTPHeader = HTTPHeaders.Element

enum APIError: Error {
  case requestFailed(Error?, Int)
  case processingError(Error?)
  case responseMissingRequiredMeta(field: String?)
  case responseHasIncorrectNumberOfElements
  case noData

  var localizedDescription: String {
    switch self {
    case .requestFailed(let error, let statusCode):
      return "APIError::RequestFailed[Status: \(statusCode) | Error: \(error?.localizedDescription ?? "UNKNOWN")]"
    case .processingError(let error):
      return "APIError::ProcessingError[Error: \(error?.localizedDescription ?? "UNKNOWN")]"
    case .responseMissingRequiredMeta(field: let field):
      return "APIError::ResponseMissingRequiredMeta[Field: \(field ?? "UNKNOWN")]"
    case .responseHasIncorrectNumberOfElements:
      return "APIError::ResponseHasIncorrectNumberOfElements"
    case .noData:
      return "APIError::NoData"
    }
  }
}

struct API {

  // MARK: - Properties
  let environment: TaskManagerEnvironment
  let session: URLSession
  let authToken: String

  // MARK: - HTTP Headers
  let contentTypeHeader: HTTPHeader = ("Content-Type", "application/json; charset=utf-8")
  var additionalHeaders: HTTPHeaders = ["Some-App-Token": Configuration.appToken]

  // MARK: - Initializers
  init(session: URLSession = URLSession(configuration: .default),
       environment: TaskManagerEnvironment = .prod,
       authToken: String) {
    self.session = session
    self.environment = environment
    self.authToken = authToken
  }
}

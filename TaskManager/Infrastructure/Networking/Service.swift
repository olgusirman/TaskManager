//
//  Service.swift
//  TaskManager
//
//  Created by Olgu on 6.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation

class Service {

  // MARK: - Properties
  let networkClient: API
  let session: URLSession

  // MARK: - Initializers
  init(client: API) {
    self.networkClient = client
    self.session = URLSession(configuration: .default)
  }
  
  // MARK: - Utilities
  var isAuthenticated: Bool {
    !self.networkClient.authToken.isEmpty
  }

  // MARK: - Internal
  func makeAndProcessRequest<R: Request>(
    request: R,
    parameters: [Parameter]? = nil,
    completion: @escaping (Result<R.Response, APIError>) -> Void) {

    let handleResponse: (Result<R.Response, APIError>) -> Void = { result in
      DispatchQueue.main.async {
        completion(result)
      }
    }

    guard let urlRequest = prepare(request: request, parameters: parameters) else {
      return
    }

    let task = session.dataTask(with: urlRequest) { data, response, error in

      guard let httpResponse = response as? HTTPURLResponse,
        200..<300 ~= httpResponse.statusCode else {
          let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
          handleResponse(.failure(.requestFailed(error, statusCode)))
          return
      }

      do {
        if let data = data {
          let value = try request.handle(response: data)
          handleResponse(.success(value))
        } else {
          handleResponse(.failure(.noData))
        }
      } catch let handleError as NSError {
        handleResponse(.failure(.processingError(handleError)))
      }
    }
    task.resume()
  }

  func prepare<R: Request>(request: R,
                           parameters: [Parameter]?) -> URLRequest? {
    let pathURL = networkClient.environment.baseUrl.appendingPathComponent(request.path)

    var components = URLComponents(url: pathURL,
                                   resolvingAgainstBaseURL: false)

    if let parameters = parameters {
      components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }

    guard let url = components?.url else {
      return nil
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    // body *needs* to be the last property that we set, because of this bug: https://bugs.swift.org/browse/SR-6687
    urlRequest.httpBody = request.body

    let authTokenHeader: HTTPHeader = ("Authorization", "Token \(networkClient.authToken)")
    let headers =
      [authTokenHeader, networkClient.contentTypeHeader]
      + [networkClient.additionalHeaders, request.additionalHeaders].joined()
    headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }

    return urlRequest
  }
}

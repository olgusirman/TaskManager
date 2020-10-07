//
//  SomeService.swift
//  TaskManager
//
//  Created by Olgu on 7.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation

class SomeService: Service {

  // MARK: - Internal
  func objects(parameters: [Parameter]? = nil,
                 completion: @escaping (_ response: Result<SomeSampleRequest.Response, APIError>) -> Void) {
    let request = SomeSampleRequest()
    makeAndProcessRequest(request: request,
                          parameters: parameters,
                          completion: completion)
  }
  
}

//
//  Configuration.swift
//  TaskManager
//
//  Created by Olgu on 7.10.2020.
//  Copyright © 2020 cloudadvise. All rights reserved.
//

import Foundation

enum Configuration {
  enum Error: Swift.Error {
    case missingKey, invalidValue
  }
  
  static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
    guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
      throw Error.missingKey
    }
    
    switch object {
    case let value as T:
      return value
    case let string as String:
      guard let value = T(string) else { throw Error.invalidValue }
      return value
    default:
      throw Error.invalidValue
    }
  }
  
  static var ssoSecret: String {
    // swiftlint:disable:next force_try
    try! value(for: "SSO_SECRET")
  }
  
  static var appToken: String {
    // swiftlint:disable:next force_try
    try! value(for: "APP_TOKEN")
  }
}

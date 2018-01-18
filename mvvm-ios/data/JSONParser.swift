//
//  JSONParser.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/30/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import SwiftyJSON

// MARK: - A utility class which converts JSON to Swift object (Repo).
class JSONParser {
  
  /// Decodes JSON file into the list of repositories
  ///
  /// - Parameter rawValue: raw data in JSON format
  /// - Returns: the list of repositories
  func decode(from rawValue: Data) -> [Repo] {
    let json = JSON(rawValue)
    var repos: [Repo] = []

    guard let items = json["items"].array else {
      print("Invalid JSON array")
      return repos
    }
    
    for item in items {
      guard let id = item["id"].int32 else{
        print("Failed to parse JSON")
        return repos
      }
      guard let name = item["full_name"].string else {
        print("Failed to parse JSON")
        return repos
      }
      
      let repo = Repo()
      repo.id = id
      repo.name = name
      repos.append(repo)
    }
    return repos
  }
}

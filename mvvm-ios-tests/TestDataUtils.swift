//
//  TestDataUtils.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/30/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
@testable import mvvm_ios

// MARK: - A utility class to provide testing data
class TestDataUtils {
  private static let SIMPLE_MOCK_JSON_STRING:String = "{\"total_count\":3,\"incomplete_results\":false,\"items\":[{\"id\":22458259,\"name\":\"Alamofire\",\"full_name\":\"Alamofire/Alamofire\"},{\"id\":21700699,\"name\":\"awesome-ios\",\"full_name\":\"vsouza/awesome-ios\"},{\"id\":3606624,\"name\":\"ReactiveCocoa\",\"full_name\":\"ReactiveCocoa/ReactiveCocoa\"}]}"
  
  static func getRawJSONData() -> Data {
    return SIMPLE_MOCK_JSON_STRING.data(using: .utf8)!
  }
  
  static func getSimpleMockRepos() -> [Repo]{
    var repos: [Repo] = []
    
    let first = Repo()
    first.id = 22458259
    first.name = "Alamofire/Alamofire"
    
    let second = Repo()
    second.id = 21700699
    second.name = "vsouza/awesome-ios"
    
    let third = Repo()
    third.id = 3606624
    third.name = "ReactiveCocoa/ReactiveCocoa"
    
    repos.append(first)
    repos.append(second)
    repos.append(third)
    
    return repos
  }
}

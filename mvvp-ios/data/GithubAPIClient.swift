//
//  GithubAPIClient.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/21/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import Alamofire

class GithubAPIClient {
  let API_HOST = "https://api.github.com/"
  let SEARCH_REPO_ENDPOINT = "search/repositories"
  
  let parser = JSONParser()
  
  private init(){}
  
  public static let shared = GithubAPIClient()
  
  /// Fetches all trending repositories written in Swift
  public func fetchTrendingRepos(completion callback: @escaping ((_ repos: [Repo], _ error: String?) -> Void)) {
    var error: String?
    var repos: [Repo] = []
    
    let urlStr = API_HOST + SEARCH_REPO_ENDPOINT
    
    let parameters: Parameters = [
      "q":"language:swift",
      "sort":"star",
      "order":"desc"
    ]
    
    Alamofire.request(urlStr, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
      .responseJSON(completionHandler: {
        response in
        // Guarantee that we get response with the HTTP status code 200.
        guard response.response?.statusCode == 200 else {
          error = "Failed to fetch data: \(String(describing: response.response?.statusCode))"
          callback(repos, error)
          return
        }
        
        error = response.error?.localizedDescription
        
        if let data = response.data {
          repos = self.parser.decode(from: data)
        }
        
        callback(repos, error)
        
      })
  }
}

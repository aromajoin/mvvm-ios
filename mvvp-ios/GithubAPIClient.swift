//
//  GithubAPIClient.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/21/17.
//  Copyright © 2017 Quang Nguyen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
public class GithubAPIClient {
  
  let API_HOST = "https://api.github.com/"
  let SEARCH_REPO_ENDPOINT = "search/repositories"
  
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
        guard response.response?.statusCode == 200 else {
          error = "Failed to fetch data: \(String(describing: response.response?.statusCode))"
          callback(repos, error)
          return
        }
        
        switch response.result {
        case .success(let value):
          let json = JSON(value)
          guard let items = json["items"].array else {
            print("Invalid JSON array")
            return
          }
          
          for item in items {
            guard let id = item["id"].int32 else{
              print("Failed to parse JSON")
              return
            }
            guard let name = item["full_name"].string else {
              print("Failed to parse JSON")
              return
            }
            
            let repo = Repo(id: id, name: name)
            repos.append(repo)
          }
          
          break
        case .failure(let e):
          error = e.localizedDescription
          break
        }
        callback(repos, error)
        
      })
  }
}

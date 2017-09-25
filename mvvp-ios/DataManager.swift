//
//  DataManager.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/25/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation

/// MARK: - A central place to manipulate data from both remote and local sources.
class DataManager {
  private let apiClient = GithubAPIClient.shared
  private let realmHelper = RealmHelper.shared
  
  private init() {}
  
  public static let shared = DataManager()
  
  public func loadRepos(online: Bool, completion callback: @escaping ((_ repos: [Repo]) -> Void)) {
    if online {
      // Force to load remote data source.
      apiClient.fetchTrendingRepos(completion: {
        repos, error in
        guard error == nil else {
          print("Get error when fetching repos: \(String(describing: error))")
          return
        }
        
        // Clear old data and save new data into realm database.
        self.realmHelper.clearAllRepos()
        for repo in repos {
          self.realmHelper.addNewRepo(repo: repo)
        }
        
        callback(repos)
      })
    } else {
      // Load local data
      
      let repos = realmHelper.loadRepos()
      
      if repos.count == 0 {
        // No local data available. Need to load from remote source.
        loadRepos(online: true, completion: callback)
      } else {
        callback(realmHelper.loadRepos())
      }
    }
  }
}

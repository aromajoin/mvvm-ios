//
//  DataManager.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/25/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import RxSwift
/// MARK: - A central place to manipulate data from both remote and local sources.
class DataManager {
  private let apiClient = GithubAPIClient.shared
  private let realmHelper = RealmHelper.shared
  
  private init() {}
  
  public static let shared = DataManager()
  
  public func loadRepos(online: Bool) -> Observable<[Repository]?> {
    if online {
      return apiClient.fetchTrendingRepos()
            .map({ $0?.items })
            .asObservable()
    } else {
      // Load local data
      let repos = realmHelper.loadRepos()
      
      if repos.count == 0 {
          return Observable.just([]).asObservable()
      }
      return Observable
            .just(repos.map({ $0.toRepository() }))
            .asObservable()
        }
    }
}

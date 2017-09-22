//
//  ReposViewModel.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/22/17.
//  Copyright © 2017 Quang Nguyen. All rights reserved.
//

import Foundation
import RxSwift

class ReposViewModel {
  let apiClient = GithubAPIClient.shared
  var requestCount = Variable<Int>(0)
  var repos: Observable<[Repo]?>!
  
  init() {
    loadTrendingRepos()
  }
  
  // TODO: Fix reload-data issue
  func loadTrendingRepos() {
    requestCount.value += 1
    repos = Observable<[Repo]?>.create{
      result -> Disposable in
      self.apiClient.fetchTrendingRepos(completion: {
        response, error in
        result.on(.next(response))
      })
      return Disposables.create()
    }
  }
}

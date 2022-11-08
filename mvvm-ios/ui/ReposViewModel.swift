//
//  ReposViewModel.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/22/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ReposViewModel {
  let dataManager = DataManager.shared
  var requestCount = BehaviorRelay<Int>(value: 0)
  var repos = BehaviorRelay<[Repo]>(value: [])
  var cachedRepos: [Repo] = []
  init() {
    // Load local data
    loadTrendingRepos(online: false)
  }
  
  func loadTrendingRepos(online: Bool) {
    requestCount.accept(requestCount.value + 1)
    
    self.dataManager.loadRepos(online: online, completion: {
      result in
      self.repos.accept(result)
      self.cachedRepos = result
    })
  }
  
  func filter(text: String) {
    if (text.count == 0) {
      repos.accept(cachedRepos)
    } else {
      let filteredRepos = cachedRepos.filter{$0.name.lowercased().contains(text.lowercased())}
      repos.accept(filteredRepos)
    }
  }
}

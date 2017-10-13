//
//  ReposViewModel.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/22/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import RxSwift

class ReposViewModel {
  let dataManager = DataManager.shared
  var requestCount = Variable<Int>(0)
  var repos = Variable<[Repo]>([])
  var cachedRepos: [Repo] = []
  init() {
    // Load local data
    loadTrendingRepos(online: false)
  }
  
  func loadTrendingRepos(online: Bool) {
    requestCount.value += 1
    
    self.dataManager.loadRepos(online: online, completion: {
      result in
      self.repos.value = result
      self.cachedRepos = result
    })
  }
  
  func filter(text: String) {
    if (text.count == 0) {
      repos.value = cachedRepos
    } else {
      repos.value = cachedRepos.filter{$0.name.lowercased().contains(text.lowercased())}
    }
  }
}

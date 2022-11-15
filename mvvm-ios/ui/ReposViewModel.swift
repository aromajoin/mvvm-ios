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
  let dataManager: DataManager
  var requestCount = BehaviorRelay<Int>(value: 0)
  var repos = BehaviorRelay<[Repository]>(value: [])
  var cachedRepos: [Repository] = []
  
  private let disposeBag = DisposeBag()
  
  init(dataManager: DataManager) {
    // Load local data
    self.dataManager = dataManager
    loadTrendingRepos(online: false)
  }
  
  func loadTrendingRepos(online: Bool) {
    requestCount.accept(requestCount.value + 1)
    dataManager.loadRepos(online: online)
          .observe(on: MainScheduler.instance)
          .subscribe(onNext: { repositories in
            guard let repositories = repositories else { return }
            self.dataManager.saveRepos(repositories: repositories)
            self.repos.accept(repositories)
            self.cachedRepos = repositories
          }).disposed(by: disposeBag)
  }
  
  func filter(text: String) {
    if (text.count == 0) {
      repos.accept(cachedRepos)
    } else {
      let filteredRepos = cachedRepos.filter{ $0.name.lowercased().contains(text.lowercased()) }
      repos.accept(filteredRepos)
    }
  }
}

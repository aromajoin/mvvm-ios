//
//  LocalDataManager.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/25/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper{
  let uiRealm = try! Realm()
  
  private init() {}
  
  public static let shared = RealmHelper()
  
  public func loadRepos() -> [Repo]{
    return Array(uiRealm.objects(Repo.self))
  }
  
  public func addNewRepo(repo: Repo) {
    try! uiRealm.write {
      uiRealm.add(repo)
    }
  }
  
  public func clearAllRepos() {
    try! uiRealm.write {
      uiRealm.delete(uiRealm.objects(Repo.self))
    }
  }
}

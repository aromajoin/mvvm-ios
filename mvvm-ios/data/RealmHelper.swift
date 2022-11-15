//
//  LocalDataManager.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/25/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    
  let uiRealm = try! Realm()
  public static let shared = RealmHelper()
  private init() {}
  
  public func loadRepos() -> [RepositoryDBModel]{
    return Array(uiRealm.objects(RepositoryDBModel.self))
  }
  
  public func addNewRepo(repo: RepositoryDBModel) {
    try! uiRealm.write {
      uiRealm.add(repo)
    }
  }
  
  public func clearAllRepos() {
    try! uiRealm.write {
      uiRealm.delete(uiRealm.objects(RepositoryDBModel.self))
    }
  }
}

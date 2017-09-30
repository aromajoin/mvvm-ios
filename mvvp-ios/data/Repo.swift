//
//  Repo.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/21/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import RealmSwift
class Repo: Object{
  dynamic var id: Int32 = -1
  dynamic var name: String = ""
  
  override func isEqual(_ object: Any?) -> Bool {
    guard object is Repo else {
      return false
    }
    let repo = object as! Repo
    
    return repo.id == self.id && repo.name == self.name
  }
}

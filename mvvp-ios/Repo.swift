//
//  Repo.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/21/17.
//  Copyright © 2017 Quang Nguyen. All rights reserved.
//

import Foundation
public struct Repo {
  public private(set) var id: Int32!
  public private(set) var name: String!
  
  public init(id: Int32, name: String) {
    self.id = id
    self.name = name
  }
}

//
//  Repo.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/21/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import RealmSwift

class RepositoryDBModel: Object {
    @objc dynamic var id: Int32 = -1
    @objc dynamic var name: String = ""
    
    override func isEqual(_ object: Any?) -> Bool {
        guard object is RepositoryDBModel else {
            return false
        }
        let repo = object as! RepositoryDBModel
        
        return repo.id == self.id && repo.name == self.name
    }
    
    func toRepository() -> Repository {
        .init(id: self.id, name: self.name)
    }
}



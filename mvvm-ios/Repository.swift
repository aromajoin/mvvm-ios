//
//  Repository.swift
//  mvvm-ios
//
//  Created by Behnam on 11/7/22.
//  Copyright © 2022 Behnam. All rights reserved.
//

import Foundation


struct Repositories: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    let id: Int32
    let name: String
    
    func toRepositoryDBModel() -> RepositoryDBModel {
        let model = RepositoryDBModel()
        model.id = self.id
        model.name = self.name
        return model
    }
}

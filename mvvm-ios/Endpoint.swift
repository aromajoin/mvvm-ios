//
//  Endpoint.swift
//  mvvm-ios
//
//  Created by Behnam on 11/7/22.
//  Copyright © 2022 Behnam. All rights reserved.
//

import Foundation

class Constants {
    static let baseUrl: String = "https://api.github.com/"
}

enum Endpoint: RequestProtocol {
    
    case searchFromRepos
    
    var baseUrl: String { Constants.baseUrl }
    var method: Method { .get }
    func getBody() -> Data? { nil }
    
    var path: String {
        return "search/repositories"
    }
    
    var queryParameters: [URLQueryItem]? {
        [.init(name: "q", value: "language:swift"),
         .init(name: "sort", value: "star"),
         .init(name: "order", value: "desc"),
         .init(name: "per_page", value: "20")]
    }
    
}

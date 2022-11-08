//
//  GithubAPIClient.swift
//  mvvm-ios
//
//  Created by Quang Nguyen on 9/21/17.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import RxSwift

class GithubAPIClient {
  
  public static let shared = GithubAPIClient(api: WebService())
  private let disposeBag = DisposeBag()
  private let api: WebService
    
  init(api: WebService){
    self.api = api
  }
    
  /// Fetches all trending repositories written in Swift
  public func fetchTrendingRepos() -> Observable<Repositories?> {
    let resource = Resource<Repositories>(endpoint: .searchFromRepos)
    return api.request(resource: resource).asObservable()
  }
}
